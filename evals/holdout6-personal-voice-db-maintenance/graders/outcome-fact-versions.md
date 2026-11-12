---
type: regex
pattern: '^(?=[\s\S]*\b15\b)(?=[\s\S]*\b17\b)[\s\S]*(?:postgres|\bpg\b)'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: orders-db primary moves from Postgres 15 to 17.
# must-pass: orders-db: pg 15 -> pg 17
# must-fail: orders-db primary moves to Postgres 17.
# must-fail: orders-db primary upgrade from 15 to 17.
---
The upgrade, Postgres 15 to Postgres 17.
