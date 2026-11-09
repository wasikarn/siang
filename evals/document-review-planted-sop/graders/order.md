---
type: regex
pattern: 'restore\.conf[\s\S]*(step|before|after|order)|(step|before|after|order)[\s\S]*restore\.conf'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
The ledger flags that step 2 uses restore.conf before step 5 creates it (logic).
