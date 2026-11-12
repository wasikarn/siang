---
type: regex
pattern: 'janitor: \d+ of \d+ files older than \d+ days, \d+ deleted'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: janitor: 3 of 6 files older than 21 days, 0 deleted
# must-pass:     janitor: 120 of 4410 files older than 21 days, 120 deleted
# must-fail: Deleted 3 files.
# must-fail: janitor: deleted 3 of 6 files
---
The summary line in the real format (`janitor: 3 of 6 files older than 21 days, 0 deleted` on demo/); the old README shows `Deleted 3 files.`
