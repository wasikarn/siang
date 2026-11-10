---
type: regex
pattern: '\bjq\b'
match: contains
target: {source: file, path: docs/sync-assets.md}
# fixture: absent
---
The doc names the jq prerequisite the script requires.
