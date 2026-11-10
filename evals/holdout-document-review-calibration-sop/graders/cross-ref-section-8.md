---
type: regex
pattern: '(?:section|sec\.?|§)\s*8\b'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: step 7 points to section 8, which the SOP does not have (it ends at section 7).
