---
type: regex
pattern: '/var/backups/snap\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: By default archives go to `/var/backups/snap/` (SNAP_DEST in snap.conf).
# must-fail: Archives go to `/backups` unless you pass `--target`.
---
The default destination is `SNAP_DEST=/var/backups/snap` from `snap.conf`, not `/backups`.
