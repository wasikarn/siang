---
type: regex
pattern: 'แจ้ง(มา)?ว่า|ใช่(ไหม|มั้ย)คะ'
match: not_contains
target: last_message
---
An acknowledgement that restates the customer's own message back to them (`รับทราบค่ะ
คุณลูกค้าแจ้งว่า... ใช่ไหมคะ`) before the answer. §59 has no Thai echo-back cue yet (ADOPT A32);
repeating the order number to confirm it is fine and is checked by `facts-kept`.
