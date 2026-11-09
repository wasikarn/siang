---
type: regex
pattern: 'sync-assets[^\n]*--bucket-name'
match: not_contains
target: {source: file, path: docs/sync-assets.md}
---
No command line passes the flag the script does not have; naming it as wrong is fine.
