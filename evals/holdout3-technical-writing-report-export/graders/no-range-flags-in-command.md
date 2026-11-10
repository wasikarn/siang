---
type: regex
pattern: 'report\.py[^\n]*--(?:until|from)\b'
match: not_contains
target: {source: file, path: docs/exporting.md}
# must-pass: There is no `--until`: everything on or after the `--since` date is exported.
# must-fail:     python3 report.py --since 2026-10-01 --until 2026-10-31
---
No command may use `--from` or `--until`; report.py has neither and exits 2 on them. Prose saying there is no end date is fine.
