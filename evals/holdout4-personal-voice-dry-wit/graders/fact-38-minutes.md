---
type: regex
pattern: '\b38\b|thirty-eight'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: Lost checkout for 38 minutes.
# must-pass: Had a 38-minute checkout outage.
# must-fail: Lost checkout for about 40 minutes.
# must-fail: Lost checkout for 83 minutes.
---
The outage length (38 minutes) survives, in any format.
