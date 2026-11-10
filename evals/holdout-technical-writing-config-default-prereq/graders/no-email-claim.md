---
type: regex
pattern: '(?<!not |n.t |never )\b(?:emailed|e-?mails? (?:the )?reports?|sends? (?:the )?reports? by e-?mail)\b|every hour|hourly'
flags: i
match: not_contains
target: {source: file, path: SETUP.md}
# must-pass: The script writes one file per run; it is not emailed to anyone.
# must-fail: Reports are emailed to the team every hour.
# must-fail: The report runs hourly.
---
Unsupported claim: nothing in the code sends email or schedules runs, so the how-to must not assert it.
