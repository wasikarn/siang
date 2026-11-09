---
type: regex
pattern: '--dest\b'
match: not_contains
target: {source: file, path: README.md}
# must-pass: ./snapshot --target /backups ~/work
# must-fail: ./snapshot --dest /backups ~/work
---
Stale claim: `--dest` does not exist; the script rejects it as an unknown option.
