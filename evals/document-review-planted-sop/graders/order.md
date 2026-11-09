---
type: regex
pattern: 'restore\.conf(?:(?!\bpass\b)[\s\S]){0,150}?(?:before|after|\border(?:ing)?\b|precede|later|earlier|too late|sequence)|(?:before|after|\border(?:ing)?\b|precede|later|earlier|too late|sequence)(?:(?!\bpass\b)[\s\S]){0,150}?restore\.conf'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
The ledger flags that step 2 uses restore.conf before step 5 creates it (logic).
