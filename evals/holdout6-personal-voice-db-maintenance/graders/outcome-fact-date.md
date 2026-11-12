---
type: regex
pattern: '\b(?:Mar(?:ch)?\.?\s+19(?:th)?|19(?:th)?\s+Mar(?:ch)?|(?:2026-)?03-19|0?3/19|19/0?3)\b'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: Thu Mar 19, 14:00-16:00 UTC
# must-pass: on Thursday 19 March
# must-pass: Thu 2026-03-19
# must-fail: on Thursday March 26
---
The maintenance date, Thursday March 19, in any format.
