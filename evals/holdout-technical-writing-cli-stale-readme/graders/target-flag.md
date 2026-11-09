---
type: regex
pattern: '--target\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: ./snapshot --target /backups ~/work
# must-fail: ./snapshot --dest /backups ~/work
---
Fact from `--help`: the destination flag is `--target DIR` (required).
