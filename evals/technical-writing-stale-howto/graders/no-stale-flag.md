---
type: regex
pattern: '--force'
match: not_contains
target: {source: file, path: docs/rotate-key.md}
---
The flag the source removed in v2 is gone from the doc (step 3: facts come from the code, not the old draft).
