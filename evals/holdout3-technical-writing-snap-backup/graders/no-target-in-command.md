---
type: regex
pattern: 'snap[ \t]+[-~/.$"''][^\n]*--target\b'
match: not_contains
target: {source: file, path: README.md}
# must-pass: `--target` was renamed to `--dest`; snap now rejects `--target`.
# must-fail:     bin/snap --source ~/notes --target /mnt/backup
---
No example command may use `--target`: snap rejects it as an unknown option and exits 2. Prose noting that `--target` was renamed or is gone is fine.
