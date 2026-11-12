---
type: regex
pattern: '^(?=[\s\S]*(?:migration|migrate|ไมเกรช|ไมเกรต))(?=[\s\S]*\b10 ?(?:นาที|min))'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: มี migration เพิ่ม column ใน payments ใช้ราว 10 นาที
# must-pass: มีไมเกรชันเพิ่มคอลัมน์ในตาราง payments ใช้เวลาประมาณ 10 นาที
# must-fail: มี migration เพิ่ม column ใน payments ใช้ไม่นาน
# must-fail: รอราว 10 นาทีแล้วจะแจ้ง
---
Fact 3: a migration adds a column and takes about 10 minutes. The draft names the migration and the 10 minutes.
