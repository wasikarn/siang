---
type: regex
pattern: '^1\. '
match: contains
flags: m
target: {source: file, path: docs/rotate-key.md}
# fixture: absent
---
The how-to has numbered steps, one action each (step 4 how-to shape).
