---
type: regex
pattern: '^(?=[\s\S]*B7731)(?=[\s\S]*(22[.:]00|สี่ทุ่ม|4 ทุ่ม))(?=[\s\S]*(0?9[.:]00|9 โมง|เก้าโมง))(?=[\s\S]*ยัง(ไม่(เปลี่ยน|อัปเดต|ขึ้น)|(ขึ้น|เป็น|แสดง|ค้าง)[^\n]{0,8}รอ)[^\n]*สลิป)'
match: contains
target: last_message
---
The specifics survive with their polarity (A10): the order number, the 22.00 cut-off, the 09.00
check (a spoken form such as `สี่ทุ่ม` or `9 โมงเช้า` is fine in chat), and the slip asked for only if the status still has not changed (`ถ้าสถานะเปลี่ยนแล้ว
ส่งสลิป` fails).
