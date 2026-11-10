---
type: regex
pattern: 'thrilled|excited to (?:share|announce)|fast.paced (?:landscape|world)'
flags: i
match: not_contains
target: {source: file, path: pr-description.md}
# fixture: present
---
The enthusiastic opener and the "fast-paced landscape" scene-setter are gone.
