---
type: regex
pattern: '\b46\b'
match: contains
target: {source: file, path: PROPOSAL.md}
# fixture: absent
# must-pass: 46 hours of on-call time
# must-fail: dozens of on-call hours
---
The draft states the 46 on-call hours.
