---
type: regex
pattern: '^(?=[^่]*(?:่[^่]*){71}$)[^้]*(?:้[^้]*){118}$'
match: contains
target: {source: file, path: regulation-clean.txt}
# fixture: absent
---
Every lowered or left-shifted mai ek (U+F70A, U+F705) becomes U+0E48 and every mai tho (U+F70B, U+F706, U+F714) becomes U+0E49: exactly 71 mai ek and 118 mai tho in the repaired file. A glyph mapped to the wrong tone, dropped, or added shifts a count. The raw text has 34 and 32.
