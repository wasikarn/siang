---
type: regex
pattern: '2027-02-29|Feb\w*\.?\s+29\W{0,4}2027|\b29\s+Feb\w*\.?,?\s+2027|2027 is not a leap year'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: Section 7 date 2027-02-29 is impossible: 2027 is not a leap year.
# must-pass: February 29, 2027 does not exist.
# must-fail: Effective date: 2026-07-01.
# must-fail: February dates should be checked for leap years.
---
Section 7 starts the new questionnaire on 2027-02-29, a date that does not exist (standard req 2).
