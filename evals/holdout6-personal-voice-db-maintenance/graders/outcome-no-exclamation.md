---
type: regex
pattern: '^(?![\s\S]*!)[\s\S]+'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: tl;dr: orders-db moves to Postgres 17 on Thu Mar 19.
# must-fail: tl;dr: Postgres 17 is coming to orders-db!
# must-fail: Thanks all!
---
No sample has an exclamation mark; the draft has none either (an empty draft fails).
