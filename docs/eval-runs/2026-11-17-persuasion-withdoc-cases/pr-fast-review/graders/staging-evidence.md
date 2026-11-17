---
type: regex
pattern: 'staging'
flags: i
match: contains
target: {source: file, path: PR.md}
# fixture: absent
# must-pass: Ran 2 days in staging with the flag on: 0 retry errors.
# must-fail: Tested and safe.
---
The draft gives the staging run as evidence.
