---
type: regex
pattern: '(?:^|\n)[ \t]*P\.?[ \t]?S\b|^\s*$'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: Probably 0 orders lost.
# must-pass: PSQL replicas were fine.
# must-fail: P.S. the old proxy is off now.
# must-fail: PS: the coffee machine works again.
---
The P.S. line appears in one sample only (03). The draft has none.
