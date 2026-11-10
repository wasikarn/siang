#!/usr/bin/env bash
# Plants runbook.md (a PostgreSQL backup-restore runbook) and runbook-standard.md (the team's runbook
# standard). Six planted defects: 500 GB vs 500 MB free space (unit), repo-cipher.txt read in 5.4 but
# fetched in 5.7 (step before it exists), "Appendix C" that does not exist (dangling reference),
# retention 35 days vs 28 days (contradicted number), no Rollback section (required by the standard),
# "restores any database in under 10 minutes" with no dated test record (unverifiable claim).
# Clean on purpose: RTO 4 hours (inside the standard's limit, stated once).
cat > runbook-standard.md <<'EOF'
# OPS-STD-02: Operational runbook standard

Every production runbook must meet all of the following.

1. Required sections, in this order: Purpose, Scope, Prerequisites, Procedure, Verification,
   Rollback, Escalation, Revision history.
2. Recovery targets: state the RTO and RPO. RTO for tier-1 databases must not exceed 4 hours;
   RPO must not exceed 15 minutes.
3. Every step must only use files, credentials, hosts or directories that exist before that step
   runs (created in an earlier step or listed in Prerequisites).
4. Every cross-reference must point to a section or appendix that exists in the same document.
5. Numbers and units stated more than once (sizes, durations, counts) must agree everywhere.
6. Any claim of tested performance must cite the last restore test: date and change ticket.
7. Backup retention must be stated once and match the backup tool configuration.
EOF
cat > runbook.md <<'EOF'
# RB-DB-014: Restore the orders database from backup

Owner: Database Reliability team · Tier: 1 · Version 1.3

## 1. Purpose

Restore the `orders` PostgreSQL 16 database on `db-orders-01` from the nightly base backup plus
archived WAL after data loss or corruption. Recovery targets: RTO 4 hours, RPO 15 minutes.
Nightly base backups are retained for 35 days.

This procedure has been tested and restores any database in under 10 minutes.
Last restore test: completed successfully.

## 2. Scope

Applies to the `orders` database in the production cluster only. Replica rebuilds use RB-DB-011.

## 3. Prerequisites

- Shell access to `db-orders-01` as the `postgres` user.
- The backup volume `/backup` is mounted and has at least 500 GB free.
- An approved change ticket for the restore.
- `pgbackrest` 2.51 installed; stanza `orders` configured.

## 4. Backup schedule (reference)

- Base backup nightly at 01:00 UTC via `pgbackrest --stanza=orders backup --type=full`.
- WAL archived continuously; `archive_timeout = 60s`.
- Old base backups are expired by `repo1-retention-full-type=time` after 28 days.

## 5. Procedure

5.1 Confirm `df -h /backup` shows at least 500 MB free before you start.

5.2 Stop application writes: scale the `orders-api` deployment to 0 replicas and confirm no client
    connections remain with `SELECT count(*) FROM pg_stat_activity WHERE datname = 'orders';`.

5.3 Stop PostgreSQL: `sudo systemctl stop postgresql@16-main`.

5.4 Open the encrypted repository with the cipher file:
    `pgbackrest --stanza=orders --repo1-cipher-pass="$(cat /srv/restore/repo-cipher.txt)" info`.

5.5 Move the damaged data directory aside: `mv /var/lib/postgresql/16/main /var/lib/postgresql/16/main.bad`.

5.6 Restore to the target time:
    `pgbackrest --stanza=orders --type=time --target="<UTC timestamp>" restore`.

5.7 Fetch the repository cipher from the vault to `/srv/restore/repo-cipher.txt`:
    `vault kv get -field=cipher secret/db/orders > /srv/restore/repo-cipher.txt`.

5.8 Start PostgreSQL: `sudo systemctl start postgresql@16-main`, and wait for recovery to finish.

## 6. Verification

- `SELECT pg_is_in_recovery();` returns `false`.
- Row count of `orders.order_items` is within 1% of the last nightly report.
- Scale `orders-api` back to its normal replica count and run the smoke test suite.

## 7. Escalation

If the restore fails twice, page the on-call DBA lead. Contact list and bridge details are in
Appendix C.

## 8. Revision history

| Version | Date | Change | Approved by |
|---|---|---|---|
| 1.3 | 2026-09-14 | Moved to pgbackrest 2.51 | DBA lead |
| 1.2 | 2026-03-02 | Added WAL archive settings | DBA lead |
EOF
