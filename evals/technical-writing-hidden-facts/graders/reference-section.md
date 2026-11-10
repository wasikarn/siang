---
type: regex
pattern: '^#+ .*(reference|options|flags|exit codes)'
match: contains
flags: im
target: {source: file, path: docs/sync-assets.md}
# fixture: absent
---
The lookup reader gets a titled reference section (two quadrants, two sections).
