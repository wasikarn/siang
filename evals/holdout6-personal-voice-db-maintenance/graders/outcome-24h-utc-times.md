---
type: regex
pattern: '^(?![\s\S]*\b\d{1,2}(?::\d{2})?\s?[ap]\.?m\b)[\s\S]*\b1[46]:00\b'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: tl;dr: orders-db moves to Postgres 17 on Thu Mar 19, 14:00-16:00 UTC.
# must-pass: After 16:00 UTC, check your error dashboard.
# must-fail: Thursday March 19, 2pm to 4pm UTC.
# must-fail: Window is 14:00-16:00 UTC, pause batch jobs before 1:45 p.m. UTC.
---
The samples write every time as 24h with UTC and never use am/pm; the prompt's "2pm", "1:45pm" and "4pm" must come out as 14:00, 13:45 and 16:00.
