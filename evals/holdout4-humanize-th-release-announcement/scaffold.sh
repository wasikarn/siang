#!/usr/bin/env bash
# Plants ANNOUNCEMENT.md, an internal Thai release announcement with machine-written tells spread through it:
# calque verbs and nominalization (ทำการ deploy, ได้รับการปรับปรุงให้มีความเสถียร, ในส่วนของ), stacked ซึ่ง ... ซึ่ง ...
# โดยที่, a "ไม่ใช่แค่ X แต่ยัง Y" frame, inflated significance (ก้าวสำคัญ, อย่างมีนัยสำคัญ), vague attribution
# (ผู้เชี่ยวชาญหลายท่านมองว่า), ครับ closing nearly every sentence, Thai numerals and a Buddhist-era date in Thai
# digits, one English term spelled two ways (deploy / ดีพลอย, cache / แคช), an em dash and a chat closer
# (หากมีข้อสงสัยประการใด).
# Facts that must survive: billing-api 4.7.0, 10 November (Tuesday), 840 ms -> 310 ms p95, 20% of tenants,
# 5 minutes of slower requests, คุณณัฐวุฒิ as on-call, ticket BILL-3317. Must stay byte-identical: the
# "ถ้าเจอ invoice ที่ยอดไม่ตรง" paragraph. The blockquote is a genuine quote from the accounting team: its
# "ไม่ได้เป็นเพียงแค่ ... แต่ยัง" wording is theirs, so it stays.
cat > ANNOUNCEMENT.md <<'EOF'
# ประกาศ: billing-api 4.7.0 ขึ้น production คืนวันอังคาร

สวัสดีครับทุกท่าน ทีม Billing ขอแจ้งให้ทราบว่าเราจะทำการ deploy billing-api เวอร์ชัน 4.7.0 ขึ้น production ในคืนวันอังคารที่ ๑๐ พฤศจิกายน ๒๕๖๙ เวลา ๒๒.๐๐ น. ครับ

## มีอะไรเปลี่ยน

รีลีสนี้ไม่ใช่แค่การอัปเดตเวอร์ชันตามรอบปกติ แต่ยังถือเป็นก้าวสำคัญของระบบ billing ทั้งหมดครับ หน้า invoice ได้รับการปรับปรุงให้มีความเสถียรมากยิ่งขึ้น — ซึ่งเป็นผลมาจากการที่ query หลักถูกเขียนใหม่ ซึ่งทำให้ p95 latency ลดลงจาก 840 ms เหลือ 310 ms โดยที่ไม่ต้องเพิ่มเครื่องครับ

นอกจากนี้เรายังย้ายแคชของ tenant config ไปไว้ใน Redis ด้วย ผู้เชี่ยวชาญหลายท่านมองว่าการแยก cache ออกจาก process แบบนี้ช่วยลดปัญหา memory ได้อย่างมีนัยสำคัญครับ

ฝ่ายบัญชีลองใช้บน staging มาสองสัปดาห์แล้ว และส่งความเห็นมาว่า

> "การปรับปรุงครั้งนี้ไม่ได้เป็นเพียงแค่การแก้ปัญหาความช้า แต่ยังช่วยให้ทีมบัญชีปิดงบได้เร็วขึ้นด้วย" (คุณพิมพ์ชนก ฝ่ายบัญชี)

## แผนการ rollout

ในส่วนของการ rollout เราจะเปิด flag ให้ tenant 20% ก่อน แล้วค่อยเพิ่มทีละขั้นภายในสัปดาห์นั้นครับ ระหว่างดีพลอยอาจมี request ช้าลงประมาณ ๕ นาทีครับ

คุณณัฐวุฒิเป็น on-call หลักของคืนนั้น รายละเอียดทั้งหมดอยู่ใน ticket BILL-3317 ครับ

ถ้าเจอ invoice ที่ยอดไม่ตรงหลังเปิด flag ให้ปิด `invoice_v2_enabled` ใน config ของ tenant นั้นก่อน แล้วแจ้งในห้อง #billing-oncall พร้อมเลข invoice ไม่ต้องรอให้ทีมเราตอบ

## สิ่งที่ทีมอื่นต้องทำ

- ทีม Checkout: ไม่ต้องทำอะไรครับ API contract เหมือนเดิมทุกจุด
- ทีม Data: ตาราง `invoice_snapshots` จะมีคอลัมน์ใหม่ `v2_total` ครับ
- ทีม Support: ถ้าลูกค้าแจ้งว่า PDF ของ invoice โหลดช้า ให้เปิดเคสใต้ BILL-3317 ได้เลยครับ

## ถ้าต้อง rollback

ทีม Billing จะ rollback กลับไป 4.6.2 เองถ้า error rate ของหน้า invoice เกิน 2% นานกว่า 10 นาที ทีมอื่นไม่ต้องทำอะไร

หากมีข้อสงสัยประการใด สามารถสอบถามเพิ่มเติมได้ตลอดเวลานะครับ ขอบคุณครับ
EOF
