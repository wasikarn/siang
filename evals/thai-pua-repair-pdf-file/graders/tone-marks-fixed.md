---
type: regex
pattern: 'ม\u0E48ม\u0E49'
match: contains
target: {source: file, path: check.txt}
# fixture: absent
---
Two ToUnicode entries in one consecutive range (U+F70A, U+F70B) read as ่ and ้.
