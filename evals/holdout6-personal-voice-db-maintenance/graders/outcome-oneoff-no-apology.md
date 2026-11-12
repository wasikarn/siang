---
type: regex
pattern: '^(?![\s\S]*\b(?:sorry|apolog\w*|inconvenien\w*)\b)[\s\S]+'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: tl;dr: orders-db moves to Postgres 17 on Thu Mar 19, 14:00-16:00 UTC.
# must-fail: tl;dr: orders-db maintenance Thu Mar 19, sorry for the short notice.
# must-fail: We apologise for any inconvenience.
---
Only one sample (03) apologises, for short notice; this post is not short notice and the user listed no apology.
