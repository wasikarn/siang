---
type: regex
pattern: '\b(?:14(?::00)?|2\s?pm)[\s\S]{0,30}\b(?:16(?::00)?|4\s?pm)[\s\S]{0,10}UTC'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: Thu Mar 19, 14:00-16:00 UTC
# must-pass: between 14:00 UTC and 16:00 UTC
# must-pass: 2pm to 4pm UTC
# must-fail: 14:00-16:00 CET
# must-fail: 14:00-15:00 UTC
# must-pass: starts 14:00 UTC, done by 16:00 UTC
---
The window, 14:00 to 16:00 UTC, in any time format (the 24h habit is graded separately).
