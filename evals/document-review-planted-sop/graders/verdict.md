---
type: regex
pattern: '\b(approve with changes|reject)\b'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
The review ends in a verdict word the skill defines, not a bare approve.
