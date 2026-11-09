---
type: regex
pattern: '(?:--keep|keeps?|kept|default|retain\w*|last|newest|most recent)[^\n]{0,60}\b(?:7|seven)\b|\b(?:7|seven)\b[^\n]{0,30}(?:snapshots|by default)'
flags: i
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: | `--keep N` | Number of snapshots to keep. Default: 7. |
# must-pass: By default the seven newest snapshots are kept.
# must-fail: Keeps the last 30 snapshots and deletes older ones.
---
Fact from `--help`: `--keep` defaults to 7 snapshots.
