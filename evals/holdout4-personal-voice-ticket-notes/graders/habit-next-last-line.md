---
type: regex
pattern: '(?:^|\n)next:[^\n]*\s*$'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: next: เพิ่ม CI check ให้ build fail ถ้า release ไม่มี migration
# must-pass: next: CI check สำหรับ migration
# must-fail: Next step: เพิ่ม CI check
# must-fail: ขั้นตอนต่อไป: เพิ่ม CI check
---
Every note ends with a line starting "next:". The draft's last line does too.
