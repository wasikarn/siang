---
type: regex
pattern: '^(?=[\s\S]*(?:merge|เมิร์จ|เมิร์ก))(?=[\s\S]*14[:.]30)'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: 14:00-14:30 ปิด merge เข้า main
# must-pass: ตั้งแต่ 14.00 ถึง 14.30 นาฬิกา ขอให้งดเมิร์จโค้ดเข้า main
# must-fail: ช่วง deploy ปิด merge เข้า main
# must-fail: 14:00-14:30 อย่าเพิ่ง push
---
Fact 2: no merges into main from 14:00 to 14:30. The draft names the merge freeze and its 14:30 end.
