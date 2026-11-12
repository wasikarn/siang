---
type: regex
pattern: '—'
match: not_contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: หน้า invoice เสถียรขึ้น เพราะเขียน query หลักใหม่
# must-pass: p95 latency ลดลงจาก 840 ms เหลือ 310 ms
# must-fail: หน้า invoice เสถียรขึ้น — ซึ่งเป็นผลมาจาก query ใหม่
# must-fail: deploy คืนวันอังคาร — 22:00
---
The fixture has one em dash, in a planted tell; the rewrite has none, so it neither keeps it nor adds new ones.
