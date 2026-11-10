---
type: regex
pattern: 'logtidy(?:\.py)?[^\n]*--dir(?:=|[ \t]+)\S'
match: contains
target: {source: file, path: README.md}
# must-pass: python3 logtidy.py --dir=/var/log/myapp --dry-run
# must-fail: python3 logtidy.py --keep-days 14
---
The command shown passes `--dir`, which argparse marks required: a command without it fails before doing anything.
