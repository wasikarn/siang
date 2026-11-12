---
type: regex
pattern: 'หากมีข้อสงสัย|สอบถามเพิ่มเติม|ขอบคุณ(?:ทุกคน|ทุกท่าน)?(?:ที่|สำหรับ)|ขอความร่วมมือ|สวัสดี(?:ครับ|ค่ะ)? ?ทุก(?:คน|ท่าน)|ขอแจ้งให้ทราบ|^(?![\s\S])'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: พฤ. 19 พ.ย. 14:00 จะ deploy payment-service ขึ้น production
# must-pass: ติดอะไรทักใน #infra ได้เลย
# must-fail: สวัสดีทุกคน ขอแจ้งกำหนดการ deploy
# must-fail: หากมีข้อสงสัยสอบถามเพิ่มเติมได้ ขอบคุณครับ
---
No generic announcement boilerplate (greetings, "ขอแจ้งให้ทราบ", "หากมีข้อสงสัย", thanks for cooperation). None of the user samples has any.
