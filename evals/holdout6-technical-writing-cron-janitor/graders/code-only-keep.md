---
type: regex
pattern: '--keep\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: --keep GLOB  never delete files whose name matches GLOB; repeatable
# must-pass: JANITOR_ROOT=demo python3 janitor.py --dry-run --keep '*.csv'
# must-fail: --exclude GLOB  skip files that match GLOB
# must-fail: Files named *.keep are never deleted.
---
`--keep GLOB` exists only in the code (and `--help`); the old README never mentions it.
