---
type: regex
pattern: 'default[^\n]{0,60}\b21\b|\b21\b[^\n]{0,40}(?:days|default)'
match: contains
target: {source: file, path: README.md}
flags: i
# fixture: absent
# must-pass: | `--max-age-days N` | Delete files older than N days (default: 21). |
# must-pass: Without --max-age-days, files older than 21 days are deleted.
# must-fail: - `--days N`: delete files older than N days (default: 7)
# must-fail: Files older than a week are deleted by default.
---
The real default age is 21 days (`DEFAULT_MAX_AGE_DAYS`, shown by `--help`); the old README says 7.
