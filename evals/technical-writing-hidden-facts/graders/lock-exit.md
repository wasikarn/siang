---
type: regex
pattern: 'remove \.sync\.lock|exit(s| code)? 3|3[^\n]*lock|lock[^\n]*\b3\b'
match: contains
flags: i
target: {source: file, path: docs/sync-assets.md}
# fixture: absent
---
The doc covers the lock and its exit code 3.
