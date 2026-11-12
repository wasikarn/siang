#!/usr/bin/env bash
# Plants docs/runbook-standard.md (9 requirements), a long docs/db-failover-runbook.md and an empty
# review.md. The runbook reads as finished but breaks the standard in 8 places, kept far apart:
# a reference to a section that does not exist, a heading number that is skipped, one drain timeout
# given two values, an impossible drill date, an acronym never spelled out, a variable used one
# section before it is set, a required section that is absent, and an unsourced performance claim.
mkdir -p docs

cat > docs/runbook-standard.md <<'EOF'
# Runbook Standard (OPS-STD-04)

Every operational runbook in the platform handbook must meet these requirements before it is
published. A reviewer checks each one and records every gap.

1. **Header.** The runbook names an owner (a team or role) and a last-reviewed date. Every date in
   the runbook is written as YYYY-MM-DD and is a real calendar date.
2. **Roles.** Every procedure section names the role that performs it.
3. **Acronyms.** Every acronym is spelled out at its first use. Exempt: SQL, DNS, IP, URL, ID, and
   units such as MB and GB.
4. **Cross-references.** Every reference to a section or step points to one that exists in the
   same document.
5. **Numbering.** Sections, subsections and numbered steps run in sequence with no gaps.
6. **Consistent values.** A timeout, threshold, retention period or size has the same value and
   unit everywhere it appears.
7. **Order.** No step uses a value, file or resource that only a later step creates.
8. **Rollback.** The runbook has a Rollback section that says how to return to the prior state if
   the procedure fails partway.
9. **Evidence.** Any claim about performance, capacity or third-party behaviour cites a source (a
   dashboard, ticket, test report or vendor document). A claim without a source must be marked
   unverified.
EOF

cat > docs/db-failover-runbook.md <<'EOF'
# orders-db Primary Failover Runbook

Owner: Database Reliability Engineering (DBRE) team
Last reviewed: 2026-10-02
Applies to: the orders-db cluster (PostgreSQL 16, Patroni 3.3, pgbouncer 1.22)

## 1. Purpose and scope

This runbook moves the orders-db primary role from a failed or degraded node to a healthy replica.
Use it for an unplanned failover, when the primary is down or unreachable, and for a planned
switchover during maintenance. It does not cover restoring the cluster from a backup.

The recovery point objective (RPO) for orders-db is 5 seconds of committed writes. The recovery
time objective (RTO) is 15 minutes from the first page to writes being accepted again.

## 2. Before you start

Performed by: on-call DBRE.

### 2.1 Access

1. Log in to the bastion host `bastion-db.int.example.net` with your personal key.
2. Confirm that `patronictl -c /etc/patroni/orders.yml list` runs without errors.

### 2.2 Know the cluster

orders-db runs on three nodes: `orders-db-1`, `orders-db-2` and `orders-db-3`. Applications reach
the database through pgbouncer, which runs on every application host and points at the primary by
host name. A virtual IP (VIP), `10.20.0.50`, follows the primary for reporting tools.

Replicas stream the write-ahead log (WAL) from the primary. Each replica reports how far it has
replayed as a log sequence number (LSN).

### 2.3 Limits

- Maximum replication lag for a promotion candidate: 16 MB of WAL.
- pgbouncer connection drain timeout: 90 seconds.
- Patroni leader lock lifetime: 30 seconds.
- Patroni promotes a healthy replica in under 8 seconds at p99, so clients see a stall, not errors.

## 3. Decide whether to fail over

Performed by: on-call DBRE, with the incident commander.

1. Check the cluster state:
   `patronictl -c /etc/patroni/orders.yml list`
2. If the primary shows `running` and accepts connections, do not fail over. Hand the incident
   back to the incident commander as an application problem.
3. If the primary is `stopped`, missing, or fails `pg_isready` for 60 seconds, go to step 4.
4. Read the `Lag in MB` column and pick the replica with the lowest lag as the candidate.
5. If every replica is above the lag limit in section 2.3, do not promote. Follow section 6.4
   and page the DBRE lead.

## 4. Fail over

Performed by: on-call DBRE.

### 4.1 Fence the old primary

1. If the old primary still answers, run `sudo systemctl stop patroni` on it to stop writes.
2. If it does not answer, ask the infrastructure on-call to power it off from the hypervisor
   console. Do not continue until they confirm in #db-incidents.
3. Record the fencing time in the incident timeline.
4. Open an ECR in the change tracker and paste its number into #db-incidents.

### 4.2 Pause traffic

1. On the deploy host, run `./pgb-all.sh pause` to send `PAUSE orders` to every pgbouncer.
2. Wait for the drain to finish. pgbouncer holds new queries while open transactions complete.
3. Point every pgbouncer at the new primary:
   `./pgb-all.sh set-host "$NEW_PRIMARY"`

### 4.3 Promote the candidate

1. Promote the candidate chosen in section 3, step 4:
   `patronictl -c /etc/patroni/orders.yml failover --candidate <candidate> --force`
2. Run `patronictl -c /etc/patroni/orders.yml list` until the candidate shows `Leader`.
3. Record the promoted host for the remaining steps:
   `export NEW_PRIMARY=<candidate>`
4. On the new primary, check that the VIP moved: `ip addr show | grep 10.20.0.50`

### 4.4 Resume traffic

1. Run `./pgb-all.sh resume`.
2. Run a smoke query through pgbouncer from the deploy host:
   `psql -h localhost -p 6432 -d orders -c 'select 1'`

## 5. Verify

Performed by: on-call DBRE.

### 5.1 Writes and replication

1. Insert and delete a row in `orders.healthcheck` through pgbouncer.
2. Confirm with `patronictl list` that every replica streams from the new primary with lag under 16 MB.

### 5.2 Application health

1. Open the orders service dashboard and confirm the error rate is back under 0.5%.

### 5.4 Backups

1. Run `./backup-check.sh orders` to confirm the next base backup will run on the new primary.
2. If the check fails, page the DBRE lead. Do not close the incident until a backup completes.

## 6. Rebuild the old primary

Performed by: DBRE lead, during working hours.

### 6.1 Reimage

Ask the infrastructure team to reimage the old primary and install PostgreSQL and Patroni from the
standard build.

### 6.2 Rejoin as a replica

Start Patroni. It clones from the new primary with `pg_basebackup` and joins as a replica.

### 6.3 Return to three nodes

Confirm three members in `patronictl list` and update the inventory sheet with each host's role.

## 7. Planned switchover

Performed by: on-call DBRE, inside an approved maintenance window.

1. Announce the window in #db-incidents 30 minutes before it starts.
2. Run `./pgb-all.sh pause`. pgbouncer waits up to 120 seconds for the drain before it reports
   a timeout.
3. Run `patronictl -c /etc/patroni/orders.yml switchover --candidate <replica>`.
4. Run `./pgb-all.sh resume` and follow section 5 to verify.

## 8. Drill history

| Date | Type | Result |
| --- | --- | --- |
| 2026-03-12 | Unplanned failover drill | Writes back in 6 minutes |
| 2026-06-18 | Planned switchover | Writes back in 2 minutes |
| 2026-09-31 | Unplanned failover drill | Writes back in 9 minutes |
EOF

: > review.md
