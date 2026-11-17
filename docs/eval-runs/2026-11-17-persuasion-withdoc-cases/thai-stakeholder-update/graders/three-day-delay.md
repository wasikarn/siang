---
type: regex
pattern: '3\s*วัน|สามวัน|3[ -]days?|three days'
flags: i
match: contains
target: {source: file, path: UPDATE.md}
# must-pass: เลื่อนออกไป 3 วัน
# must-pass: ช้ากว่าเดิมสามวัน
# must-fail: ขอเลื่อนวัน go-live ออกไปเล็กน้อย
---
The update states the size of the delay: 3 days.
