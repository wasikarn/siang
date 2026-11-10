---
type: regex
pattern: '\bexports/|(?:--out|dir\s*=)[^\n]*\bexports\b|\bexports\b[^\n]*(?:--out|default)'
match: contains
target: {source: file, path: docs/exporting.md}
# fixture: absent
# must-pass: The file lands in `exports/events-2026-10-01.csv`.
# must-pass: | `--out DIR` | output directory | `exports` |
# must-fail: report.py writes an Excel workbook to `out/`, named after the range.
---
Files go to `exports` (`dir` in `report.toml`), or to the directory given with `--out`; not `out/`.
