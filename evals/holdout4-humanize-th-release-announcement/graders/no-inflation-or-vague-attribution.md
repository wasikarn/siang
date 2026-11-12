---
type: regex
pattern: 'ก้าวสำคัญ|ยกระดับ|อย่างมีนัยสำคัญ|ผู้เชี่ยวชาญ|หลายท่านมองว่า|หลายฝ่าย(?:มอง|เห็น)'
match: not_contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: เราย้ายแคชของ tenant config ไปไว้ใน Redis เพื่อลด memory ของ process
# must-pass: p95 latency ลดลงจาก 840 ms เหลือ 310 ms
# must-fail: ผู้เชี่ยวชาญหลายท่านมองว่าการแยก cache ออกจาก process ช่วยได้
# must-fail: ถือเป็นก้าวสำคัญของระบบ billing ทั้งหมด
---
Planted: "ถือเป็นก้าวสำคัญของระบบ billing", "ได้อย่างมีนัยสำคัญ" and the unnamed experts in "ผู้เชี่ยวชาญหลายท่านมองว่า". Any rewording that drops them passes.
