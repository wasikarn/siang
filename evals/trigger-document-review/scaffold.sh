#!/usr/bin/env bash
mkdir -p docs
: > review.md
cat > docs/standard.md <<'FIXTURE_EOF'
# Operations document standard OPS-7

A procedure document must contain these sections, in this order:

1. Purpose
2. Prerequisites
3. Procedure
4. Rollback
5. Contacts

Every procedure step must name the file or command it uses. Durations carry a unit. Owner and revision date sit in the header.
FIXTURE_EOF
cat > docs/sop-restore.md <<'FIXTURE_EOF'
# SOP: restore the orders database

Owner: data-platform. Revision: 2026-10-02.

## 1. Purpose

Restore the orders database from the nightly snapshot. Snapshots are kept for 90 days.

## 2. Prerequisites

Access to the `backup-ops` role. For the lock steps, see section 7.

## 3. Procedure

1. Stop the app: `systemctl stop orders-app`.
2. Load the settings with `restore --config restore.conf`.
3. Wait 30 minutes for the replica to drain.
4. Run `restore --snapshot latest --target orders`.
5. Create `restore.conf` with the target host and the snapshot bucket.
6. After the 30 s wait, start the app: `systemctl start orders-app`.

## 4. Contacts

On-call: data-platform pager.
FIXTURE_EOF
