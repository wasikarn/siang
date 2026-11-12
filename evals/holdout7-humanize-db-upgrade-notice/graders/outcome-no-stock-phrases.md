---
type: regex
pattern: 'ทำการ|ยิ่งไปกว่านั้น|อย่างมีนัยสำคัญ|อย่าลังเล'
match: not_contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: ทีม DBA จะอัปเกรด cluster นี้ สงสัยอะไรถามคุณพิมพ์ชนกได้เลย
# must-fail: ทีม DBA จะทำการอัปเกรด cluster นี้
# must-fail: หากมีข้อสงสัย อย่าลังเลที่จะติดต่อ
# must-fail: ช่วยเพิ่มความเสถียรอย่างมีนัยสำคัญ
---
Translated-English filler goes: the empty verb "ทำการ", the "ยิ่งไปกว่านั้น" connector, the unsupported "อย่างมีนัยสำคัญ" claim, and "อย่าลังเลที่จะ" (from "don't hesitate to").
