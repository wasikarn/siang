---
type: regex
pattern: '(?:restart|รีสตาร์ท)[^\n]{0,40}(?:หลัง(?:จาก)?|เมื่อ|ตอน(?:ที่)?|ทุกครั้งที่|ถ้า|หาก)\s*(?:มีการ\s*)?(?:เปลี่ยน(?:ค่า)?\s*)?`?REDIS_URL'
match: not_contains
target: last_message
---
The time clause is no longer tacked on after the action in English order
(`ต้อง restart auth-api ทุกครั้งหลัง REDIS_URL เปลี่ยน`). Thai puts the trigger first:
`เปลี่ยน REDIS_URL เมื่อไหร่ ต้อง restart auth-api`.
