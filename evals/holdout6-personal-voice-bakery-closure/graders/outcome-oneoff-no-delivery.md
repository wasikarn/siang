---
type: regex
pattern: '^(?![\s\S]*(?:grab|line ?man|เดลิเวอรี่?|ไรเดอร์|ค่าส่ง|จัดส่ง|ส่งถึงบ้าน))[\s\S]+'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: มารับที่ร้านวันที่ 24 ธ.ค. 13.00-17.00 น.
# must-fail: ใครไม่สะดวกมารับ สั่งผ่าน Grab ได้นะคะ
# must-fail: มีบริการจัดส่ง ค่าส่งตามระยะทาง
---
Delivery through Grab appears in one old post (03) only; the user listed pick-up at the shop, so the draft offers no delivery.
