---
type: regex
pattern: '[\uF700-\uF71A]'
match: not_contains
target: {source: file, path: check.txt}
---
No mapped Windows Thai PUA glyph is left in the text of out.pdf, on any of the 12 fonts.
