---
type: regex
pattern: '^(?![\s\S]*(?:^|\n)[ \t]*p\.?\s?s\.?\b)[\s\S]+'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: Postgres 17 goes live on orders-db Thu Mar 19.
# must-pass: psql users: nothing changes for read queries.
# must-fail: P.S. there is cake in the kitchen.
# must-fail: PS: the runbook is in the wiki.
---
Only one sample (02) has a P.S. line; it is a one-off, so the draft has none.
