---
type: regex
pattern: ';'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: The variance is $48,250; Daniel Okafor has traced most of it.
# must-fail: The variance is $48,250. Daniel Okafor has traced most of it.
---
Every one of Marta's notes joins related clauses with a semicolon; the draft has none. A rewrite in her voice uses at least one.
