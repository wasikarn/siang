#!/usr/bin/env bash
cat > report.py <<'FIXTURE_EOF'
#!/usr/bin/env python3
"""Write a daily sales summary CSV to the output directory named in config.ini."""
import configparser
import csv
import os
import sys
from datetime import datetime
from zoneinfo import ZoneInfo

cfg = configparser.ConfigParser()
if not cfg.read("config.ini"):
    sys.exit("report: config.ini not found in the current directory")
section = cfg["report"]
out_dir = section.get("output_dir", "out")
tz = ZoneInfo(section.get("timezone", "UTC"))

db_url = os.environ.get("REPORT_DB_URL")
if not db_url:
    sys.exit("report: set REPORT_DB_URL to the sales database URL")
if not os.path.isdir(out_dir):
    sys.exit(f"report: output directory '{out_dir}' does not exist")

now = datetime.now(tz)
path = os.path.join(out_dir, f"sales-{now:%Y-%m-%d}.csv")
with open(path, "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["generated_at", "source"])
    w.writerow([now.isoformat(), db_url.split("@")[-1]])
print(f"report: wrote {path}")
FIXTURE_EOF
chmod +x report.py
cat > config.ini <<'FIXTURE_EOF'
[report]
output_dir = out
# timezone = Asia/Bangkok
FIXTURE_EOF
cat > SETUP.md <<'FIXTURE_EOF'
# Setup

1. Run `python3 report.py`.
2. Edit config.ini if you want.

Report times use your local time zone. Reports are emailed to the team every hour.
FIXTURE_EOF
