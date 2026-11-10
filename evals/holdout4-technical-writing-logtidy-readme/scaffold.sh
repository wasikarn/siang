#!/usr/bin/env bash
# Builds a tiny Python CLI, logtidy.py, with its config and changelog, plus a stale README.md.
# Facts in the code: --dir is required, --keep-days defaults to 14 (logtidy.ini), --dry-run exists,
# --older-than was renamed to --keep-days in 0.3.0, the target directory must hold a .logtidy-ok
# marker file, and only the top level of --dir is scanned (os.scandir, no recursion).
# The README is wrong on the flag name, the default (30) and claims recursion.
set -euo pipefail

cat > logtidy.py <<'PY'
#!/usr/bin/env python3
"""Delete old .log files from one directory."""
import argparse
import configparser
import os
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
cfg = configparser.ConfigParser()
cfg.read(HERE / "logtidy.ini")
DEFAULT_KEEP = cfg.getint("defaults", "keep_days")


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--dir", required=True, help="directory holding the .log files")
    p.add_argument("--keep-days", type=int, default=DEFAULT_KEEP,
                   help="keep files modified within this many days")
    p.add_argument("--dry-run", action="store_true",
                   help="print what would be deleted, delete nothing")
    a = p.parse_args()
    d = Path(a.dir)
    if not (d / ".logtidy-ok").exists():
        sys.exit(f"logtidy: refusing to touch {d}: no .logtidy-ok marker file there")
    cutoff = time.time() - a.keep_days * 86400
    for e in os.scandir(d):
        if e.is_file() and e.name.endswith(".log") and e.stat().st_mtime < cutoff:
            print(("would delete " if a.dry_run else "deleting ") + e.path)
            if not a.dry_run:
                os.remove(e.path)


if __name__ == "__main__":
    main()
PY
chmod +x logtidy.py

cat > logtidy.ini <<'INI'
[defaults]
keep_days = 14
INI

cat > CHANGELOG.md <<'MD'
# Changelog

## 0.3.0
- `--older-than` is renamed to `--keep-days`.
- logtidy now refuses to run on a directory without a `.logtidy-ok` marker file.

## 0.2.0
- Added `--dry-run`.
MD

cat > README.md <<'MD'
# logtidy

Recursively deletes old `.log` files under a directory, including every subdirectory.

## Usage

```
python3 logtidy.py --dir /var/log/myapp --older-than 30
```

Files older than 30 days are deleted by default.
MD
