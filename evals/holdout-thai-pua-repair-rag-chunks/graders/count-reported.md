---
type: regex
pattern: '^\s*7\s*$'
match: contains
target: {source: file, path: pua-left.txt}
# fixture: absent
---
After a correct repair exactly seven private-use characters remain (the unmappable U+F71B x4, U+F71C x2, U+F71D x1). A count by eye, a count of the raw file (211) or a claim of zero fails.
