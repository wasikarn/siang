---
type: regex
pattern: '2026-09-31|Sep\w*\.?\s+31\b|\b31(?:st)?\s+(?:of\s+)?Sep'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: Drill history row 3 has an impossible date, 2026-09-31 (September has 30 days).
# must-pass: The drill date September 31 does not exist.
# must-fail: Drill dates 2026-03-12 and 2026-06-18 are valid.
# must-fail: The last drill was in September 2026.
---
The drill history lists 2026-09-31, a date that does not exist (standard req 1).
