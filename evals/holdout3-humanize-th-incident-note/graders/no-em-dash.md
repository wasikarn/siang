---
type: regex
pattern: '—'
flags: u
match: not_contains
target: {source: file, path: incident-note.md}
# fixture: present
---
No em dash survives; Thai engineers rarely type one.
