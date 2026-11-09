---
type: regex
pattern: '\*\*[^*\n]+\*\*'
match: not_contains
target: {source: file, path: draft.md}
---
Only one of three samples uses bold text, so it is not a habit; the rewrite drops the draft’s bold.
