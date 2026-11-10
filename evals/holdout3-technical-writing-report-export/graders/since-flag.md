---
type: regex
pattern: '--since\b'
match: contains
target: {source: file, path: docs/exporting.md}
# fixture: absent
# must-pass:     python3 report.py --since 2026-10-01
# must-fail:     python3 report.py --from 2026-10-01 --until 2026-10-31 --format xlsx
---
The start date is passed with `--since YYYY-MM-DD`, which is required. The draft used `--from`, which argparse rejects.
