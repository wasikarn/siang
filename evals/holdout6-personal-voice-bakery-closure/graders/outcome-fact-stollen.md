---
type: regex
pattern: '[สช](?:โต|ตอ)ล?เล.?น|stollen'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: เปิดพรีออเดอร์สโตเลนคริสต์มาสค่ะ
# must-pass: Christmas stollen ก้อนละ 390.-
# must-fail: เปิดพรีออเดอร์ขนมคริสต์มาสค่ะ
# must-pass: สตอลเลนก้อนละ 390.-
# must-pass: ชโตเลนคริสต์มาส
---
The pre-order item, Christmas stollen, in Thai or English spelling.
