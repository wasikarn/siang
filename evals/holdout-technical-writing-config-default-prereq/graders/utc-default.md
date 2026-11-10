---
type: regex
pattern: '\bUTC\b'
match: contains
target: {source: file, path: SETUP.md}
# fixture: absent
# must-pass: If `timezone` is not set, times are in UTC.
# must-fail: Report times use your local time zone.
---
Non-obvious default from the code: with no `timezone` key (the shipped config.ini has it commented out), times are UTC.
