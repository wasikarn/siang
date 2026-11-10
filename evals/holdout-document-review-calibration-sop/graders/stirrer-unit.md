---
type: regex
pattern: '\b300\b'
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: step 5 sets the stirrer to 300 with no unit (rpm).
