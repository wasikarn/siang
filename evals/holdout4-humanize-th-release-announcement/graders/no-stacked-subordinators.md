---
type: regex
pattern: 'ซึ่ง[^\n]{0,80}(?:ซึ่ง|โดยที่)'
match: not_contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: เราเขียน query หลักใหม่ ทำให้ p95 latency ลดจาก 840 ms เหลือ 310 ms โดยไม่ต้องเพิ่มเครื่อง
# must-pass: query หลักถูกเขียนใหม่ ซึ่งทำให้ latency ลดลง
# must-fail: ซึ่งเป็นผลมาจากการที่ query หลักถูกเขียนใหม่ ซึ่งทำให้ p95 latency ลดลง
# must-fail: ซึ่งทำให้ latency ลดลงโดยที่ไม่ต้องเพิ่มเครื่อง
---
The planted sentence chains ซึ่ง ... ซึ่ง ... โดยที่ in one breath. One ซึ่ง on its own is fine; two linked clauses within 80 characters are not.
