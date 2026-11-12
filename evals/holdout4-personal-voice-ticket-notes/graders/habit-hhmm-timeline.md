---
type: regex
pattern: '(?<![\d.:])(?:1[3-9]|2[0-3]):[0-5]\d(?!\d|[ \t]*น)[\s\S]*(?<![\d.:])(?:1[3-9]|2[0-3]):[0-5]\d(?!\d|[ \t]*น)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: - 14:05 deploy v4.12.0 ขึ้น prod - 14:22 Nok rollback
# must-pass: 14:05 deploy ขึ้น prod แล้ว 14:22 rollback
# must-fail: 2:05 pm deploy แล้ว 2:22 pm rollback
# must-fail: 14:05 น. deploy และ 14:22 น. rollback
---
The user's timeline uses 24-hour HH:MM with a colon and no "น." (all 5 notes); the bank email's "01.00 น." is not theirs. The prompt gives 12-hour times (2:05 pm), so at least 2 afternoon times must come out as 14:05-style.
