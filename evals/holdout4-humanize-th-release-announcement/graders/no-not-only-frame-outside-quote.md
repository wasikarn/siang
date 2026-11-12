---
type: regex
pattern: '^(?!\s*>).*(?:ไม่ใช่แค่|ไม่ใช่เพียง|ไม่ได้เป็นเพียง|ไม่เพียงแต่|ไม่ได้มีแค่)[^\n]{0,120}แต่(?:ยัง|เป็น)'
flags: m
match: not_contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: > "การปรับปรุงครั้งนี้ไม่ได้เป็นเพียงแค่การแก้ปัญหาความช้า แต่ยังช่วยให้ทีมบัญชีปิดงบได้เร็วขึ้นด้วย" (คุณพิมพ์ชนก ฝ่ายบัญชี)
# must-pass: รอบนี้เปลี่ยนเยอะกว่ารอบปกติ หน้า invoice เร็วขึ้นชัดเจน
# must-fail: รีลีสนี้ไม่ใช่แค่การอัปเดตเวอร์ชันตามรอบปกติ แต่ยังถือเป็นก้าวสำคัญของระบบ billing
# must-fail: รอบนี้ไม่เพียงแต่แก้บั๊ก แต่ยังเร็วขึ้นด้วย
---
The "ไม่ใช่แค่ X แต่ยัง Y" frame in the team's own prose goes. The same frame inside the blockquote is a genuine quote from the accounting team and must not trip this grader (lines starting with > are skipped).
