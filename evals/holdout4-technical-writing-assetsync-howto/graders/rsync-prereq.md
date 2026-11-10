---
type: regex
pattern: '\brsync\b'
flags: i
match: contains
target: {source: file, path: docs/howto-sync-assets.md}
# fixture: absent
# must-pass: You need rsync installed (`command -v rsync`).
---
The script exits with "rsync is not installed" when rsync is missing; the how-to names rsync as a prerequisite or as the tool doing the copy.
