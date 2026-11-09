---
type: regex
pattern: '[\uF700-\uF71A]'
match: not_contains
target: {source: file, path: raw.txt}
---
Every mapped Windows Thai PUA glyph is gone from the file.
