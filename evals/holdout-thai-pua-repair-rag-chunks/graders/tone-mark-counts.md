---
type: regex
pattern: '^(?=[^่]*(?:่[^่]*){130}$)[^้]*(?:้[^้]*){120}$'
match: contains
target: {source: file, path: chunks.jsonl}
# fixture: absent
---
Every mai ek glyph (U+F70A, U+F705) becomes U+0E48 and every mai tho glyph (U+F70B, U+F706, U+F714) becomes U+0E49: exactly 130 and 120 in the repaired file (62 and 27 raw). One glyph mapped to the wrong tone, dropped or added shifts a count.
