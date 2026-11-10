---
type: regex
pattern: 'พี่ต้น[^\n]{0,20}?(?:เมื่อ|ถ้า|หาก|กรณี|ตอน|ทุกครั้งที่)[^\n]{0,40}?(?:error|เออเร่อ|2\s*%)'
match: not_contains
target: last_message
---
The page-the-lead request no longer hangs its trigger at the end (`page พี่ต้นด้วยครับเมื่อ error rate ... เกิน 2%`). Also catches `ถ้า`, `หาก`, `กรณี`, `ตอน` or `ทุกครั้งที่` after the main clause.
