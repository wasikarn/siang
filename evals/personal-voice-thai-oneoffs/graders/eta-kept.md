---
type: regex
pattern: '10[.:]00|10 โมง|สิบโมง'
match: contains
target: {source: file, path: draft.md}
---
The author fact (new time) survives.
