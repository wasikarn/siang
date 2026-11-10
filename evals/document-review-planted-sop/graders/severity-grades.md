---
type: regex
pattern: '\b(blocks|misleads)\b'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
Findings carry the skill's consequence grades (step 3).
