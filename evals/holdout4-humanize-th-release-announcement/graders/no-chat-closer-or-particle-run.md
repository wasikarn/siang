---
type: regex
pattern: 'หากมีข้อสงสัย|สอบถาม(?:เพิ่มเติม)?ได้(?:ตลอด|เลย)|หวังว่า[^\n]{0,40}ประโยชน์|(?:ครับ[\s\S]*?){4}'
match: not_contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: สวัสดีครับ ทีม Billing จะ deploy 4.7.0 คืนวันอังคาร
# must-pass: มีคำถามถามในห้อง #billing-oncall ได้ ขอบคุณครับ
# must-fail: หากมีข้อสงสัยประการใด สามารถสอบถามเพิ่มเติมได้ตลอดเวลานะครับ
# must-fail: deploy คืนนี้ครับ ช้าลง 5 นาทีครับ on-call คือคุณณัฐวุฒิครับ ดูใน BILL-3317 ครับ
---
The chat-style closer ("หากมีข้อสงสัยประการใด สามารถสอบถามเพิ่มเติมได้ตลอดเวลา") goes, and ครับ no longer closes nearly every sentence: the fixture has it 13 times, the rewrite at most 3.
