---
type: regex
pattern: '\b(?:2|two)[ -]weeks?\b|\b20 engineer[- ]days\b|\b(?:10|ten) (?:working )?days\b'
flags: i
match: contains
target: {source: file, path: PROPOSAL.md}
# must-pass: Two engineers for two weeks.
# must-pass: 20 engineer-days.
# must-fail: Some time for refactoring.
---
The draft states the size of the ask.
