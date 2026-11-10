---
type: regex
pattern: '^\s*Heyy+\b'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
---
Every sample opens with "Heyy"; the draft opens with "Dear colleagues".
