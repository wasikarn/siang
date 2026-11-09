---
type: regex
pattern: '[\uF700-\uF71A]'
match: not_contains
target: {source: file, path: check.txt}
---
The text extracted from out.pdf has no mapped Windows Thai PUA glyph left.
