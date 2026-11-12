---
type: regex
pattern: '\b390\b'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: ก้อนละ 390.-
# must-pass: ราคา 390 บาท
# must-fail: ก้อนละ 350.-
---
The price, 390 baht a loaf, in any format (the ".-" habit is graded separately).
