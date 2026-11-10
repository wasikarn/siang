---
type: regex
pattern: 'B-?7'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: step 3 uses buffer B-7, which step 6 only prepares later.
