---
type: regex
pattern: '(?:16:00|4\s?pm|after)[\s\S]{0,80}dashboard|dashboard[\s\S]{0,80}(?:16:00|4\s?pm|after)'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: 3) After 16:00 UTC, check your service's error dashboard.
# must-pass: Check your error dashboard once the window closes after 16:00 UTC.
# must-fail: 3) Check your logs.
---
After the window (16:00 UTC), teams check their service's error dashboard.
