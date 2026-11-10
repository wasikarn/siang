#!/usr/bin/env bash
# Builds a tiny export CLI: report.py (argparse, reads report.toml with tomllib), its config, a sample
# event log, and an old draft how-to. The draft says Python 3.8+ (report.py exits below 3.11), uses
# --from and --until (only --since exists; there is no end date), shows --format xlsx and says the
# script writes an Excel workbook (choices are csv and json, default csv), and names out/ as the output
# directory (report.toml: exports). The output file is <dir>/events-<since>.<format>.
set -euo pipefail
mkdir -p docs data

cat > report.py <<'PY'
#!/usr/bin/env python3
"""Export events from the local event log on or after a date, as CSV or JSON."""
import sys

if sys.version_info < (3, 11):
    sys.exit("report.py needs Python 3.11 or newer (it reads report.toml with tomllib)")

import argparse
import csv
import json
import os
import tomllib
from datetime import date

with open(os.environ.get("REPORT_CONFIG", "report.toml"), "rb") as f:
    cfg = tomllib.load(f)

p = argparse.ArgumentParser(description=__doc__)
p.add_argument("--since", required=True, type=date.fromisoformat,
               help="first day to include, YYYY-MM-DD (inclusive); everything after it is exported too")
p.add_argument("--format", choices=["csv", "json"], default=cfg["output"]["format"])
p.add_argument("--out", default=cfg["output"]["dir"], help="directory to write into")
args = p.parse_args()

rows = []
with open(cfg["input"]["path"], encoding="utf-8") as f:
    for line in f:
        ev = json.loads(line)
        if date.fromisoformat(ev["day"]) >= args.since:
            rows.append(ev)

os.makedirs(args.out, exist_ok=True)
dest = os.path.join(args.out, f"events-{args.since.isoformat()}.{args.format}")
with open(dest, "w", encoding="utf-8", newline="") as f:
    if args.format == "json":
        json.dump(rows, f, ensure_ascii=False, indent=2)
    else:
        w = csv.DictWriter(f, fieldnames=["day", "user", "action"])
        w.writeheader()
        w.writerows(rows)
print(f"wrote {len(rows)} events to {dest}")
PY

cat > report.toml <<'TOML'
[input]
path = "data/events.jsonl"

[output]
format = "csv"
dir = "exports"
TOML

cat > data/events.jsonl <<'JSONL'
{"day": "2026-09-28", "user": "u17", "action": "login"}
{"day": "2026-10-02", "user": "u04", "action": "upload"}
{"day": "2026-10-15", "user": "u17", "action": "share"}
{"day": "2026-11-03", "user": "u22", "action": "login"}
JSONL

cat > docs/exporting.md <<'MD'
# Exporting events

Requires Python 3.8 or newer.

Pick a date range and run:

    python3 report.py --from 2026-10-01 --until 2026-10-31 --format xlsx

report.py writes an Excel workbook to `out/`, named after the range. Open it in Excel or Google Sheets.
MD
