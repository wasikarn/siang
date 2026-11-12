---
type: regex
pattern: '\b15\b[\s\S]{0,120}(?:next|following)\s+(?:Thu|Thursday|week)|(?:next|following)\s+(?:Thu|Thursday|week)[\s\S]{0,120}\b15\b|\b15\b[\s\S]{0,120}(?:Mar(?:ch)?\.?\s+26|26\s+Mar|03-26|3/26)'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: If the switchover fails we stay on Postgres 15 and try again next Thursday.
# must-pass: If it fails, we stay on 15 and retry Thu Mar 26.
# must-fail: If the switchover fails we roll back.
---
If the switchover fails, orders-db stays on Postgres 15 and the upgrade is retried next Thursday.
