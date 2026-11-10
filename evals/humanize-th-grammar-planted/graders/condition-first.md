---
type: regex
pattern: 'ช้าลง[^\n]*(เมื่อ|ตอน|ถ้า|หาก)[^\n]*อัปโหลด'
match: not_contains
target: last_message
---
§44: the condition leads (`พอมีคนอัปโหลดรูปพร้อมกันเยอะ request ก็ช้าลง...`); the planted English
order hangs `เมื่อ...` after the main clause. Limit: only this one clause is checked.
