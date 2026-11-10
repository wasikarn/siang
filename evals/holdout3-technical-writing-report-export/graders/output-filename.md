---
type: regex
pattern: 'events-(?:<|\{|YYYY|\d{4}-\d{2}-\d{2})'
flags: i
match: contains
target: {source: file, path: docs/exporting.md}
# fixture: absent
# must-pass: You get `exports/events-2026-10-01.csv`.
# must-pass: The file is named `events-<since>.<format>`.
# must-fail: report.py writes an Excel workbook to `out/`, named after the range.
---
The reader has to find the file: it is `events-<since date>.<format>` inside the output directory, named after the start date only, not a range.
