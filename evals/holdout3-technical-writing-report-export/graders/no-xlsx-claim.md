---
type: regex
pattern: 'report\.py[^\n]*--format[ =]xlsx|(?<!never |not |n''t )\bwrites (?:an? )?(?:Excel|xlsx|\.xlsx)\b'
match: not_contains
target: {source: file, path: docs/exporting.md}
# must-pass: Excel output (xlsx) is not supported; open the CSV in Excel instead.
# must-fail:     python3 report.py --since 2026-10-01 --format xlsx
# must-fail: report.py writes an Excel workbook to `out/`.
---
report.py only writes CSV or JSON. The doc must not show `--format xlsx` or say it writes an Excel file. Saying xlsx is unsupported, or that the CSV opens in Excel, is fine.
