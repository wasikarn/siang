---
type: regex
pattern: '(?:--format|format\s*=)[^\n]*\bcsv\b|\bcsv\b[^\n]*\bdefault|\bdefault[^\n]*\bcsv\b'
flags: i
match: contains
target: {source: file, path: docs/exporting.md}
# fixture: absent
# must-pass: | `--format` | `csv` or `json` | `csv` (from report.toml) |
# must-pass: Without `--format` you get CSV, the default set in report.toml.
# must-fail: report.py writes an Excel workbook to `out/`, named after the range.
---
`--format` takes `csv` or `json`; the default is `csv`, from `format = "csv"` in `report.toml`.
