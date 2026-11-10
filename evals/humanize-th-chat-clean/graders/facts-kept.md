---
type: regex
pattern: '^(?=[\s\S]*staging[^\n]*ยัง(พัง|ไม่ผ่าน|ไม่ขึ้น|error|fail))(?=[\s\S]*REDIS_URL)(?=[\s\S]*พรุ่งนี้)'
match: contains
target: last_message
---
The specifics survive with their polarity (A10): staging is still broken (`deploy ผ่านแล้ว`
fails), the suspected `REDIS_URL`, and tomorrow as the time to look again.
