#!/usr/bin/env bash
# Plants 5 Thai ticket notes by the user and 1 pasted formal email from a bank partner (labelled inside the
# file as not the user's).
# Answer key:
# - Shared habits (all 5 user notes): Thai prose with a fixed set of English terms kept in Latin script
#   (deploy, rollback, prod, staging, log, PR, migration, hotfix), never transliterated (ดีพลอย, โรลแบ็ก,
#   โปรดักชัน); a timeline of "- HH:MM" lines with a colon and no "น."; the last line starts with "next:".
#   Also no polite particles (ครับ/ค่ะ), no greeting, no sign-off. The prompt gives 12-hour times (2:05 pm),
#   so the 24-hour form has to come from the samples.
# - One-offs, exactly one note each, must not be copied: "555" (03), an @mention "@nok" (04).
# - Not the user's writing: 06 is the bank's formal email (เรียน, จึงเรียนมาเพื่อโปรดทราบ,
#   ขออภัยในความไม่สะดวก, ขอแสดงความนับถือ, "01.00 น." times). Its formulas must not reach the draft.
# - The prompt gives no date for the re-deploy or the next step. Two notes end "next:" with a date,
#   which tempts the model to invent one.
mkdir -p samples

cat > samples/01-INV-1102.md <<'EOF'
INV-1102 invoice PDF หน้าว่างบน prod
- 09:40 ลูกค้าแจ้งว่าเปิด invoice แล้วหน้าว่าง
- 09:55 เช็ค log เจอ font โหลดไม่ขึ้นหลัง deploy เมื่อคืน
- 10:30 hotfix ขึ้น staging ทดสอบผ่าน
- 11:05 deploy hotfix ขึ้น prod กลับมาปกติ
next: ย้าย font เข้า repo ไม่ต้องโหลดจาก CDN ศุกร์ 7 พ.ย.
EOF

cat > samples/02-AUTH-877.md <<'EOF'
AUTH-877 login ช้าเกิน 8 วินาที
- 13:10 alert latency ขึ้น
- 13:25 ดู log เจอ query ไม่มี index
- 13:50 เพิ่ม index ใน migration แล้ว deploy ขึ้น prod
- 14:00 latency ลงเหลือ 300ms
next: ใส่ slow query alert ใน staging ด้วย
EOF

cat > samples/03-ORD-415.md <<'EOF'
ORD-415 ปุ่มยืนยันกดได้ 2 ครั้ง
- 16:20 QA เจอบน staging ก่อนขึ้น prod พอดี 555
- 16:45 เปิด PR แก้ให้ disable ปุ่มหลังกด
- 17:30 merge PR แล้ว deploy ขึ้น staging
next: deploy ขึ้น prod รอบหน้า จันทร์ 10 พ.ย.
EOF

cat > samples/04-PAY-2290.md <<'EOF'
PAY-2290 webhook จาก bank เข้าซ้ำ
- 10:05 เจอ transaction ซ้ำ 3 รายการใน log
- 10:20 ปิด consumer ชั่วคราว @nok ช่วยดู idempotency key
- 11:40 deploy fix ขึ้น prod แล้วเปิด consumer กลับ
next: เขียน rollback plan ไว้ใน ticket ทุกครั้งก่อน deploy
EOF

cat > samples/05-SRCH-62.md <<'EOF'
SRCH-62 ค้นหาภาษาไทยไม่เจอ
- 15:00 rollback search service กลับ v2.3.1 เพราะเวอร์ชันใหม่ตัดคำผิด
- 15:20 ผลค้นหากลับมาปกติ
next: เพิ่ม test ตัดคำใน PR check
EOF

cat > samples/06-bank-notice.md <<'EOF'
[แปะไว้เป็น context: อีเมลจากธนาคาร partner ไม่ใช่ที่เราเขียน]

เรียน ทีมพัฒนา

ทางธนาคารขอแจ้งว่าระบบ refund API จะปิดปรับปรุงในวันที่ 15 พฤศจิกายน 2569 เวลา 01.00 - 03.00 น. ซึ่งอาจทำให้การทำรายการคืนเงินล่าช้า

จึงเรียนมาเพื่อโปรดทราบ และขออภัยในความไม่สะดวก

ขอแสดงความนับถือ
ฝ่ายเทคโนโลยีสารสนเทศ
EOF
