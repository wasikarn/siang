---
type: regex
pattern: 'batch|nightly|sync|429'
flags: i
match: contains
target: {source: file, path: EMAIL.md}
# fixture: absent
# must-pass: At 100% our nightly batch sync fails.
# must-fail: It would be bad for us.
---
The draft says what breaks at 100%: the nightly batch sync.
