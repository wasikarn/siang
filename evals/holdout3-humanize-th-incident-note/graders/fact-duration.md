---
type: regex
pattern: '47\s?(?:นาที|min)'
flags: iu
match: contains
target: {source: file, path: incident-note.md}
# fixture: present
---
The outage length (47 minutes) survives.
