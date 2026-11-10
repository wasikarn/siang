---
type: regex
pattern: '(ลูกค้า|(?<!ของ)คุณ)(ได้)?แจ้ง(มา)?ว่า|แจ้งมาว่า|ใช่(ไหม|มั้ย)คะ'
match: not_contains
target: last_message
# must-pass: ถ้าแอปยังแจ้งว่ารอชำระเงิน ส่งสลิปในแชทนี้ได้เลยนะคะ
# must-pass: หากธนาคารของคุณแจ้งว่าโอนสำเร็จ กรุณาส่งสลิปค่ะ
# must-fail: คุณลูกค้าแจ้งว่าโอนแล้ว ใช่ไหมคะ
# must-fail: ลูกค้าแจ้งมาว่าโอนแล้ว
---
An acknowledgement that restates the customer's own message back to them (`รับทราบค่ะ
คุณลูกค้าแจ้งว่า... ใช่ไหมคะ`) before the answer. The cue is §59's Thai echo-back line. The app's own status (`ถ้าแอปยังแจ้งว่ารอชำระเงิน`) is not an
echo and passes; repeating the order number to confirm it is fine and is checked by `facts-kept`.
