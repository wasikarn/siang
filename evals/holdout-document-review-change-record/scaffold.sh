#!/usr/bin/env bash
cat > standard.md <<'FIXTURE_EOF'
# OPS-STD-07: Change record standard

A change record must be complete before the change advisory board (CAB) approves it.

## Required sections

1. Summary (what changes, which systems, how many)
2. Risk and impact
3. Implementation plan (numbered steps)
4. Rollback plan
5. Approvals
6. Post-change verification

## Rules

- C1. Every duration and every time carries a unit or time zone (for example `45 min`, `02:00 UTC`).
- C2. Counts and targets agree everywhere they appear in the record.
- C3. Each step only uses objects (groups, tickets, rules) that exist or that an earlier step creates.
- C4. Statements about impact or past success cite evidence: a ticket, a test result or a monitoring link.
FIXTURE_EOF
cat > change-record.md <<'FIXTURE_EOF'
# CHG-4417: Tighten inbound firewall rules on the web tier

## 1. Summary

Replace the broad inbound rule `allow-any-443` with per-source rules on the 12 web-tier hosts.

## 2. Risk and impact

Low risk. This change has zero customer impact, as shown by earlier changes of the same kind.

## 3. Implementation plan

Window: Saturday 02:00 to 04:00 UTC.

1. Announce the start in the #ops-changes channel.
2. Apply the new rule set to host group fw-batch-b.
3. Check that the load balancer health checks stay green.
4. Create host group fw-batch-b with the second half of the web hosts.
5. Wait 45 between batches, then repeat steps 2 and 3 for the remaining hosts.
6. Remove `allow-any-443` from all 18 web-tier hosts.

## 5. Approvals

- Requested by: network team
- CAB approval: pending

## 6. Post-change verification

Run the synthetic HTTPS check from three regions and confirm the error rate stays under 0.5 %.
FIXTURE_EOF
cat > review.md <<'FIXTURE_EOF'
Status: no issues found
FIXTURE_EOF
