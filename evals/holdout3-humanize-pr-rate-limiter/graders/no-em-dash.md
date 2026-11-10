---
type: regex
pattern: '—'
flags: i
match: not_contains
target: {source: file, path: pr-description.md}
# fixture: present
---
No em dash survives; a hand-written PR uses commas, periods or parentheses.
