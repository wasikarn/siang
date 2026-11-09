---
type: regex
pattern: '^(?![\s\S]*((?<!ไม่)สามารถ[^\n]{0,15}โอนเงินได้|ยัง(สามารถ)?โอนเงินได้|โอนเงินได้(ตาม)?ปกติ|ไม่ปิด))(?=[\s\S]*(ไม่สามารถ|ไม่ได้|ไม่สำเร็จ|ไม่พร้อม|งด|ระงับ|หยุด|ปิด))[\s\S]*โอนเงิน'
match: contains
target: last_message
# must-pass: ช่วงนี้จะโอนเงินไม่ได้นะคะ
# must-pass: ช่วงตีหนึ่งถึงตีสามโอนเงินไม่สำเร็จ
# must-pass: ช่วงนี้ท่านจะไม่สามารถทำธุรกรรมโอนเงินได้
# must-pass: ระหว่างนี้งดให้บริการทุกรายการ รวมถึงการโอนเงิน
# must-pass: ระบบโอนเงินจะปิดให้บริการชั่วคราว
# must-pass: ระหว่างบำรุงรักษา บริการโอนเงินไม่พร้อมใช้งาน
# must-fail: ระบบปิดปรับปรุง แต่โอนเงินได้ตามปกติ
# must-fail: ช่วงนี้โอนเงินได้ ไม่ปิดบริการ
# must-fail: ระหว่างนี้ยังโอนเงินได้ สอบถาม Call Center
# must-pass: ไม่สามารถโอนเงินได้ ขออภัยในความไม่สะดวก
# must-fail: ปิดปรับปรุงระบบ 01.00–03.00 น. สอบถาม Call Center
---
The notice's one real consequence for the user, that transfers stop during the window, survives the rewrite. The bare word `โอนเงิน` is not enough: a rewrite that says transfers work as usual must fail (audit 2026-11-10). shortcut: a bare
`ระหว่างนี้โอนเงินได้` (no ยัง, สามารถ or ปกติ) after a closure word still passes; switch to an LLM judge if
runs show that form.
