---
type: regex
pattern: 'downtime|down ?time|ดาวน์ไทม์|outage|ใช้งานไม่ได้|ไม่สามารถใช้งาน|หยุดให้บริการ|ระบบล่ม|กระทบลูกค้า|ผลกระทบต่อลูกค้า|^(?![\s\S])'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: มี migration เพิ่ม column ใน payments ใช้ราว 10 นาที
# must-pass: ถ้า error rate เกิน 2% จะ rollback ทันที
# must-fail: ช่วง migration ระบบอาจใช้งานไม่ได้ราว 10 นาที
# must-fail: คาดว่าจะมี downtime ประมาณ 10 นาที
---
Invention check: the user never said payments will be unavailable or customers affected. A 10-minute migration (and the HR sample's "ระบบอาจไม่สามารถใช้งานได้ชั่วคราว") tempts a downtime claim; it must not appear.
