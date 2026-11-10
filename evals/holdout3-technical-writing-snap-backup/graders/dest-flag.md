---
type: regex
pattern: '--dest\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: | `--dest DIR` | where archives go |
# must-fail: Archives go to `/backups` unless you pass `--target`.
---
The output directory option is `--dest` (short `-d`). The old README called it `--target`.
