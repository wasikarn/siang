---
type: regex
pattern: '\p{Extended_Pictographic}'
match: not_contains
flags: u
target: {source: file, path: draft.md}
---
The emoji appears in one sample only: a one-off, so it stays out of the draft.
