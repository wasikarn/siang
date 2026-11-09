---
type: regex
pattern: ';'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
---
Every sample uses a semicolon; the draft has none.
