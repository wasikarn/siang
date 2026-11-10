---
type: regex
pattern: '(?:default|--src|\bSRC\b)[^\n]{0,80}\bdist\b|\bdist\b[^\n]{0,80}(?:default|\bSRC\b|assetsync\.conf)'
flags: i
match: contains
target: {source: file, path: docs/howto-sync-assets.md}
# fixture: absent
# must-pass: By default the source is `dist/` (`SRC` in `assetsync.conf`).
# must-pass: | `--src DIR` | `dist` | Directory to upload |
# must-fail: The default source is `./public`.
---
The default source directory is `dist` (`SRC=dist` in `assetsync.conf`), not `./public`. Any wording or a table row tying `dist` to the default, `--src` or the config passes.
