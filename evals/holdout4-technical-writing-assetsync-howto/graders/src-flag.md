---
type: regex
pattern: '--src(?![\w-])'
match: contains
target: {source: file, path: docs/howto-sync-assets.md}
# fixture: absent
# must-pass: bin/assetsync --src=build
# must-fail: bin/assetsync --source public
---
The how-to names the current source flag, `--src` (either `--src DIR` or `--src=DIR`).
