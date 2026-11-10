---
type: regex
pattern: '(?:--bwlimit|\bBWLIMIT\b|bandwidth)[^\n]{0,80}\b500\b|\b500\b[^\n]{0,80}(?:--bwlimit|\bBWLIMIT\b|bandwidth)'
flags: i
match: contains
target: {source: file, path: docs/howto-sync-assets.md}
# fixture: absent
# must-pass: | `--bwlimit KBPS` | `500` | rsync bandwidth cap in KB/s |
# must-pass: Uploads are capped at 500 KB/s; raise it with --bwlimit=2000.
# must-fail: bin/assetsync --bwlimit 200
---
`--bwlimit` defaults to 500 KB/s (`BWLIMIT=500` in `assetsync.conf`); the how-to gives that default with the option.
