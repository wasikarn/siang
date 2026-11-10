---
type: regex
pattern: '1[,. ]?250|1\.25\s?k'
flags: i
match: contains
target: {source: file, path: draft.md}
---
The account count (1,250) survives the rewrite.
