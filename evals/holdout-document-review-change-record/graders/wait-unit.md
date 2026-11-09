---
type: regex
pattern: '\b45\b'
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: step 5 says wait 45 with no unit.
