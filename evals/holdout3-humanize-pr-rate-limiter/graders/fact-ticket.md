---
type: regex
pattern: 'PAY-4127'
flags: i
match: contains
target: {source: file, path: pr-description.md}
# fixture: present
---
The ticket number PAY-4127 survives.
