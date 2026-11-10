---
type: regex
pattern: 'ไม่ใช่แค่[\s\S]{0,80}แต่ยัง'
flags: u
match: not_contains
target: {source: file, path: incident-note.md}
# fixture: present
---
The "not just X but also Y" framing around the cause is gone.
