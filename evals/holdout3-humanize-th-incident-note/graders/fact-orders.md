---
type: regex
pattern: '3[,. ]?200|3\.2\s?(?:k|พัน)'
flags: iu
match: contains
target: {source: file, path: incident-note.md}
# fixture: present
---
The stuck order count (3,200) survives.
