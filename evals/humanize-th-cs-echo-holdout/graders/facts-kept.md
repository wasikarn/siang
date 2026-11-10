---
type: regex
pattern: '^(?=[\s\S]*WS-20418)(?=[\s\S]*0?8[:.]52)(?=[\s\S]*10[:.]15)(?=[\s\S]*(?:5|ห้า)\s*ครั้ง)(?=[\s\S]*30\s*นาที)(?=[\s\S]*ลืมรหัสผ่าน)(?=[\s\S]*(?:ภาพหน้าจอ|แคปหน้าจอ|screenshot|สกรีนช็อต))(?=[\s\S]*(?<!ไม่)(?<!ไม่ได้)ปลดล็อก(?!ไม่))(?![\s\S]*ยังไม่(?:ได้)?ปลดล็อก)'
match: contains
target: last_message
---
Every specific in the source survives: account `WS-20418`, lock time 08:52, 5 wrong passwords,
unlock time 10:15, the "ลืมรหัสผ่าน" step, the 30-minute reset link, and the send-a-screenshot
fallback. Polarity: the account is still said to be unlocked, not reversed to not-yet-unlocked.
