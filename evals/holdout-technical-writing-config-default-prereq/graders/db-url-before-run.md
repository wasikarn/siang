---
type: regex
pattern: 'REPORT_DB_URL[\s\S]*report\.py'
match: contains
target: {source: file, path: SETUP.md}
# fixture: absent
# must-pass: 1. export REPORT_DB_URL=postgres://user@host/sales\n2. python3 report.py
# must-pass: REPORT_DB_URL=postgres://u@h/sales python3 report.py
# must-fail: 1. Run `python3 report.py`.
---
Missing prerequisite, in order: `REPORT_DB_URL` must be set before `report.py` runs, or it exits with an error.
