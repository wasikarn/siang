#!/usr/bin/env bash
# Plants janitor.py (deletes files older than N days under JANITOR_ROOT) and a stale README.md.
# Truths only the code or a real run shows: default age 21 days (README: 7), lock held exits 4
# (README: 1), JANITOR_ROOT env var is required and --path is gone (argparse exit 2), --keep exists
# only in code, the summary line is "janitor: N of M files older than D days, K deleted", and the
# cron slot moved off 03:00 without the new time being recorded anywhere here.
# demo/ holds 6 files: 3 aged 30 days, 1 aged 10 days, 2 fresh, so the default dry run prints
# "janitor: 3 of 6 files older than 21 days, 0 deleted".
set -euo pipefail

cat > janitor.py <<'EOF'
#!/usr/bin/env python3
"""Delete files older than --max-age-days under $JANITOR_ROOT. Meant to run from cron."""
import argparse
import fnmatch
import os
import sys
import time

DEFAULT_MAX_AGE_DAYS = 21
LOCK_NAME = ".janitor.lock"

EXIT_OK = 0
EXIT_CONFIG = 3   # JANITOR_ROOT unset or not a directory
EXIT_LOCKED = 4   # another run holds the lock file

# Cron: no longer 03:00, it clashed with the backup window (OPS-412).
# The new slot is in the ops calendar, not in this repo.


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--max-age-days", type=int, default=DEFAULT_MAX_AGE_DAYS,
                   help="delete files older than this many days (default: %(default)s)")
    p.add_argument("--keep", action="append", default=[], metavar="GLOB",
                   help="never delete files whose name matches GLOB; repeatable")
    p.add_argument("--dry-run", action="store_true", help="list what would go, delete nothing")
    args = p.parse_args()

    root = os.environ.get("JANITOR_ROOT", "")
    if not os.path.isdir(root):
        print(f"janitor: JANITOR_ROOT is not set or not a directory: {root!r}", file=sys.stderr)
        return EXIT_CONFIG

    lock = os.path.join(root, LOCK_NAME)
    try:
        fd = os.open(lock, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
    except FileExistsError:
        print(f"janitor: lock held, another run is active: {lock}", file=sys.stderr)
        return EXIT_LOCKED

    try:
        cutoff = time.time() - args.max_age_days * 86400
        seen = old = 0
        for dirpath, _, names in os.walk(root):
            for name in sorted(names):
                if name == LOCK_NAME:
                    continue
                seen += 1
                path = os.path.join(dirpath, name)
                if any(fnmatch.fnmatch(name, g) for g in args.keep):
                    continue
                if os.path.getmtime(path) < cutoff:
                    old += 1
                    if args.dry_run:
                        print(f"would delete {os.path.relpath(path, root)}")
                    else:
                        os.remove(path)
        deleted = 0 if args.dry_run else old
        print(f"janitor: {old} of {seen} files older than {args.max_age_days} days, {deleted} deleted")
    finally:
        os.close(fd)
        os.remove(lock)
    return EXIT_OK


if __name__ == "__main__":
    sys.exit(main())
EOF
chmod +x janitor.py

cat > README.md <<'EOF'
# janitor

Deletes old files from an upload directory. Runs nightly from cron at 03:00.

## Usage

    python3 janitor.py --path /srv/uploads [--days N] [--dry-run]

Options:

- `--path DIR`: directory to clean (required)
- `--days N`: delete files older than N days (default: 7)
- `--dry-run`: list what would be deleted, delete nothing

## Install

1. Copy `janitor.py` to `/opt/janitor/`.
2. Try it: `python3 /opt/janitor/janitor.py --path /srv/uploads --dry-run`
3. Add it to the crontab:

       0 3 * * * python3 /opt/janitor/janitor.py --path /srv/uploads

When it finishes it prints `Deleted 3 files.` If another run is still going, it exits with status 1.
EOF

mkdir -p demo
for f in report-2026-09.csv upload-81723.bin upload-81724.bin thumb-9921.png upload-90011.bin notes.txt; do
  printf 'sample %s\n' "$f" > "demo/$f"
done
python3 - <<'EOF'
import os, time
now = time.time()
for name, days in [("report-2026-09.csv", 30), ("upload-81723.bin", 30), ("upload-81724.bin", 30), ("thumb-9921.png", 10)]:
    t = now - days * 86400
    os.utime(os.path.join("demo", name), (t, t))
EOF
