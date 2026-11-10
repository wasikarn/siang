---
type: regex
pattern: 'อย่างเดียว(?![^\n]*ด้วย)'
match: not_contains
target: last_message
---
§46: an additive `ไม่ได้...อย่างเดียว` frame closes its second half with `ด้วย`. A rewrite that
drops the frame (two plain sentences) also passes.
