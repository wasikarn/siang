#!/usr/bin/env bash
# Plants db-upgrade-notice.md: a Thai maintenance notice a careless LLM wrote. Tells: a "ในยุคที่"
# opener, "ไม่ใช่แค่...แต่ยัง", "ก้าวสำคัญ", em dashes, emoji, "ทำการ", "ยิ่งไปกว่านั้น", an
# unsupported "อย่างมีนัยสำคัญ" claim, "อย่าลังเลที่จะ", a rally-cry closer. Traps: versions 14.11 and
# 16.4, cluster pg-orders-prod-01, OPS-2291, Sat 21 Nov 2569 01:00-03:30, rollback call at 02:45,
# 40 minutes read-only, three service names, the psql line and the ERROR line must survive verbatim.
set -euo pipefail

cat > db-upgrade-notice.md <<'EOF'
# 🚀 ประกาศ: อัปเกรด PostgreSQL ของระบบ Orders

ในยุคที่ข้อมูลคือหัวใจของธุรกิจ การดูแลฐานข้อมูลให้ทันสมัยอยู่เสมอไม่ใช่แค่ทางเลือก แต่ยังเป็นสิ่งจำเป็นอย่างยิ่ง — และนี่คือก้าวสำคัญของทีมเรา

ทีม DBA จะทำการอัปเกรด cluster `pg-orders-prod-01` จาก PostgreSQL 14.11 เป็น 16.4 ในวันเสาร์ที่ 21 พ.ย. 2569 เวลา 01:00–03:30 น. (ตั๋ว OPS-2291)

## ✅ สิ่งที่จะเกิดขึ้น

- **ช่วง read-only:** ฐานข้อมูลจะอยู่ในโหมด read-only ประมาณ 40 นาที ระหว่างนั้นการเขียนทุกอย่างจะไม่สำเร็จ
- **ผลกระทบต่อ service:** orders-api จะตอบ 503 สำหรับ POST /orders ส่วน billing-worker และ report-cron จะหยุดชั่วคราว
- **จุดตัดสินใจ rollback:** ถ้าถึง 02:45 น. แล้วยังไม่ผ่าน smoke test เราจะ rollback กลับไป 14.11 ทันที

ถ้า app ของคุณเห็น error นี้ใน log ระหว่างช่วงนั้น ถือว่าปกติ ไม่ต้องแจ้ง:

> ERROR: cannot execute INSERT in a read-only transaction

## 🔍 สิ่งที่ทีมต้องทำก่อนวันจริง

นอกจากนี้ ขอให้แต่ละทีมทำการทดสอบว่า service เชื่อมต่อ replica ได้ โดยรันคำสั่งนี้:

```bash
psql "$ORDERS_RO_URL" -c "SELECT version();"
```

ยิ่งไปกว่านั้น การอัปเกรดครั้งนี้จะช่วยเพิ่มประสิทธิภาพ ความเสถียร และความปลอดภัยให้กับระบบอย่างมีนัยสำคัญ — ทำให้เราพร้อมรับการเติบโตในอนาคต

หากมีข้อสงสัยใดๆ อย่าลังเลที่จะติดต่อคุณพิมพ์ชนก (on-call DBA) ได้ที่ #db-maint 🙏

มาร่วมกันขับเคลื่อนระบบของเราไปสู่อนาคตที่แข็งแกร่งยิ่งขึ้นด้วยกัน! 💪
EOF
