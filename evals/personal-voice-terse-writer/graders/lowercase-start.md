---
type: regex
pattern: '^[a-z]'
match: contains
flags: m
target: {source: file, path: draft.md}
# fixture: absent
---
The samples start lowercase, and so does the draft.
