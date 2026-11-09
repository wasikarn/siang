---
type: regex
pattern: '(\uF71B[\s\S]*){12}'
match: contains
target: {source: file, path: check.txt}
---
U+F71B stays on all 12 lines: neither deleted nor guessed.
