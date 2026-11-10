---
type: regex
pattern: '(?:--keep|SNAP_KEEP)[^\n]*\b(?:5|five)\b|\b(?:5|five)\b[^\n]*(?:--keep|SNAP_KEEP)|\b(?:5|five) (?:newest|most recent|latest)\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: | `-k`, `--keep N` | 5 | archives to keep |
# must-pass: snap keeps the five newest archives of each directory.
# must-pass: SNAP_KEEP=5
# must-fail: snap keeps the 10 newest archives for each directory
---
snap keeps `SNAP_KEEP=5` archives per source directory unless `--keep N` is passed; the old README said 10.
