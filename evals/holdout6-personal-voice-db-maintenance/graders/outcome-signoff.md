---
type: regex
pattern: '(?:^|\n)-m\s*$'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: -m
# must-fail: - Mara
# must-fail: Thanks, Mara
# must-fail: -m and the infra team
---
Every sample ends with "-m" on its own last line.
