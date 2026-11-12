---
type: regex
pattern: '(?:ปิดรับ|ภายใน|ก่อน|ถึง|หมดเขต|ไม่เกิน|สุดท้าย)[^\n]{0,30}\b21\b|\b21\b[^\n]{0,30}(?:ปิดรับ|หมดเขต|สุดท้าย)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: ปิดรับวันอาทิตย์ที่ 21 ธ.ค.
# must-pass: สั่งได้ถึงวันที่ 21 ธันวาคม
# must-fail: สั่งได้เลยตั้งแต่วันนี้
---
Pre-orders close on Sunday 21 December.
