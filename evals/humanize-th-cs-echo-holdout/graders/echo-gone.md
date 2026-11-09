---
type: regex
pattern: 'ขอทวน|ทวน(?:ให้|นะ|อีกที)|ถูกต้อง(?:ไหม|มั้ย|มั๊ย|หรือเปล่า|รึเปล่า)|ใช่(?:ไหม|มั้ย|มั๊ย|หรือเปล่า)(?:คะ|ครับ)|(?:จาก|ตาม)ที่(?:ลูกค้า|คุณ\S{0,8})(?:เล่า|แจ้ง|บอก)'
match: not_contains
target: last_message
---
The opening that reads the customer's own problem back to them and asks them to confirm it is gone.
The customer already knows what happened; the reply should start with the answer. Catches the
planted read-back (`ขอทวนนะคะ ... ถูกต้องไหมคะ`) and close rewordings (`ใช่ไหมคะ`, `จากที่คุณนภาเล่ามา`,
`ตามที่ลูกค้าแจ้ง`). Limit: a restatement with no read-back marker and no confirm question passes.
