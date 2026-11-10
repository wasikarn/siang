#!/usr/bin/env bash
# Plants three Slack posts Nok wrote and a draft in formal Thai corporate voice. Nok's shared habits:
# casual sentence-final particles (นะ, จ้า), English tech terms in lowercase (deploy, rollback, staging,
# hotfix, prod), and short chat lines with no formal salutation or closing. The draft has none of them
# and carries four facts that must survive: คุณวิภา, 1,284 orders, INC-4417 and 12 พฤศจิกายน 2569.
set -euo pipefail
mkdir -p samples

cat > samples/1.md <<'EOF'
ทุกคน staging ล่มไปแป๊บนึงนะ
ตอนนี้ rollback แล้ว กลับมาปกติละ
สาเหตุคือ config ของ redis ผิด เดี๋ยวเราแก้ให้
มีอะไรทักมาได้เลยจ้า
EOF

cat > samples/2.md <<'EOF'
hotfix ตัวเมื่อวาน deploy ขึ้น prod แล้วนะ
ใครเจอ error แปลกๆ แปะ log ในเธรดนี้ได้เลย
เราเฝ้า dashboard อยู่ถึงเย็นนะ
EOF

cat > samples/3.md <<'EOF'
อัพเดตเรื่อง migration หน่อย
ตอนนี้ไปได้ 70% ละ ช้ากว่าที่คิดนิดนึง
พรุ่งนี้น่าจะ deploy ได้ ถ้า qa ผ่าน
ฝากเช็ค ticket ใน jira ด้วยนะจ้า
EOF

cat > draft.md <<'EOF'
เรียนทุกท่าน

ทางทีมงานขอแจ้งให้ทราบว่า เมื่อวันที่ 12 พฤศจิกายน 2569 ได้เกิดเหตุการณ์ขัดข้องกับระบบชำระเงินบน Production Environment ส่งผลให้คำสั่งซื้อจำนวน 1,284 รายการไม่สามารถดำเนินการได้ตามปกติ โดยเหตุการณ์ดังกล่าวได้รับการบันทึกไว้ในหมายเลข INC-4417 เป็นที่เรียบร้อยแล้ว

ทั้งนี้ คุณวิภา ได้ดำเนินการ Rollback ระบบกลับสู่เวอร์ชันก่อนหน้า และได้ทำการ Deploy Hotfix บน Staging Environment เพื่อทดสอบเพิ่มเติมก่อนนำขึ้นใช้งานจริง

หากท่านมีข้อสงสัยประการใด สามารถติดต่อทางทีมงานได้ตลอดเวลา

ขอแสดงความนับถือ
ทีมวิศวกรรม
EOF
