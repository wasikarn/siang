---
type: regex
pattern: '^1\. '
match: contains
flags: m
target: {source: file, path: docs/sync-assets.md}
# fixture: absent
---
The first-time reader gets numbered steps.
