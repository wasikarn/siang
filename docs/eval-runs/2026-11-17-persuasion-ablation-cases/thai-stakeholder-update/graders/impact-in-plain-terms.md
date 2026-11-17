---
type: regex
pattern: '18\s?%|18 เปอร์เซ็นต์|ร้อยละ\s?18|1 ใน 5|หนึ่งในห้า|1 in 5'
match: contains
target: {source: file, path: UPDATE.md}
# fixture: absent
# must-pass: ลูกค้าประมาณ 1 ใน 5 จะไม่ได้รับรหัส
# must-pass: ส่ง OTP ไม่สำเร็จ 18%
# must-pass: ส่งไม่สำเร็จร้อยละ 18
# must-fail: มีปัญหาเรื่อง SMS นิดหน่อย
---
The update says how many customers the problem hits (18%, or about 1 in 5).
