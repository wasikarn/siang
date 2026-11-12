---
type: regex
pattern: '\b14[\s-]*days?\b|\b(?:two|2)[\s-]*weeks?\b|\bfourteen[\s-]*days?\b'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: Added an alert that fires 14 days before any cert expires.
# must-pass: Added a 14-day expiry alert.
# must-fail: Added an alert that fires before any cert expires.
# must-fail: Added an alert that fires 7 days out.
---
The new alert's lead time (14 days) survives; a spelled-out form passes here and fails the digits grader.
