---
type: regex
pattern: '^# Rotat(e|ing)\b'
match: contains
flags: m
target: {source: file, path: docs/rotate-key.md}
# fixture: absent
---
The title names the goal, not the topic ("Rotate the key", not "Key rotation").
