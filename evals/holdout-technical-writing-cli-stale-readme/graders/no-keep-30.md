---
type: regex
pattern: '\b30 snapshots|(?:keeps?|kept|last|retain\w*)[^\n]{0,20}\b30\b'
flags: i
match: not_contains
target: {source: file, path: README.md}
# must-pass: By default the 7 newest snapshots are kept.
# must-fail: Keeps the last 30 snapshots and deletes older ones.
---
Stale claim: the README says 30 snapshots are kept; the script keeps 7 unless `--keep` says otherwise.
