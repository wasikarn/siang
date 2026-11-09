---
type: regex
pattern: '\b(?:14|21)\b'
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: Scope says every 14 days, Records says due 21 days after; either number names the conflict.
