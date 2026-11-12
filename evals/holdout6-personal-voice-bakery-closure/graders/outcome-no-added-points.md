---
type: regex
pattern: '^(?![\s\S]*(?:ส่วนลด|ลดราคา|โปรโมชั่น|ของแถม|แถมฟรี|จำนวนจำกัด|มีจำกัด|หมดแล้วหมดเลย|สะสมแต้ม|มัดจำ|โอนเงิน|เลขบัญชี))[\s\S]+'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: ปิดรับวันอาทิตย์ที่ 21 ธ.ค. ทักแชทมาได้เลยค่ะ
# must-fail: ทำจำนวนจำกัดนะคะ ใครอยากได้รีบทักมา
# must-fail: พี่จะส่งเลขบัญชีให้ในแชท
# must-fail: บัตรสะสมแต้มใช้ได้ตามปกติค่ะ
---
No point the user did not list: no discount, gift, scarcity claim, deposit or payment step (sample 05's account number), or loyalty card (sample 04).
