---
type: regex
pattern: 'สวัสดี|ขอบคุณ|หากมีข้อสงสัย|สอบถามเพิ่มเติม|ขออภัย|ครับ|ค่ะ|\b(?:hi|hey) (?:team|all)\b|^\s*$'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: PAY-2318 refund error หลัง deploy
# must-pass: ครั้งหน้าต้องมี CI check
# must-fail: สวัสดีครับทีม
# must-fail: ขอบคุณ Nok ที่ rollback ทันค่ะ
---
No greeting, thanks, apology or polite particle; the user's notes have none.
