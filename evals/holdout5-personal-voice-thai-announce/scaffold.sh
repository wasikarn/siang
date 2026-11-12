#!/usr/bin/env bash
# Plants five of the user's Thai team-channel announcements and one HR notice, labelled as not the user's.
# Shared habits (user samples): English tech terms kept in Latin script (deploy, staging, merge, migration,
# rollback); short dates "อ. 3 พ.ย." and 24-hour HH:MM times with a colon; every post ends
# "ติดอะไรทักใน #infra ได้เลย". One-offs, one sample each, not to be copied: the laugh "555"
# (rollback-search), a "ปล." postscript (oncall-swap). HR notice: formal letter style (เรียน...,
# จึงเรียนมาเพื่อโปรดทราบ, ขออภัยในความไม่สะดวก) and a downtime line. Weekdays match the 2026 calendar.
# draft.md is the model's output, absent here.
mkdir -p samples

cat > samples/deploy-auth-staging.md <<'EOF'
พรุ่งนี้ (อ. 3 พ.ย.) 10:00 จะ deploy auth-service ตัวใหม่ขึ้น staging ก่อน
ถ้าเทสผ่านค่อยขึ้น production ตอน 15:00
- ระหว่างนั้น staging อาจช้าหน่อย
ติดอะไรทักใน #infra ได้เลย
EOF

cat > samples/rollback-search.md <<'EOF'
เมื่อคืน rollback search-api ไปแล้วนะ index พังตอน 22:10 555 ไม่ใช่ความผิดใคร config เก่าค้างอยู่
วันนี้ 13:00 จะ deploy ใหม่อีกรอบ
ติดอะไรทักใน #infra ได้เลย
EOF

cat > samples/migration-orders.md <<'EOF'
ศ. 6 พ.ย. 18:00 ปิด merge เข้า main ชั่วคราว จะรัน migration ของ orders table
น่าจะใช้ราว 20 นาที เสร็จแล้วจะแจ้งในนี้
- ถ้า pipeline แดงช่วงนั้นไม่ต้องตกใจ
ติดอะไรทักใน #infra ได้เลยครับ
EOF

cat > samples/oncall-swap.md <<'EOF'
on-call สัปดาห์นี้เปลี่ยนเป็นต้นนะ (จ. 9 ถึง อา. 15 พ.ย.)
alert ไหนไม่แน่ใจ ping ต้นก่อน แล้วค่อย escalate
ติดอะไรทักใน #infra ได้เลย

ปล. ใครยืมสาย HDMI ห้องประชุมไป เอาคืนด้วยนะ
EOF

cat > samples/staging-cluster-move.md <<'EOF'
อัปเดต: staging ย้ายไป cluster ใหม่แล้วตั้งแต่ 09:30
url เดิมใช้ได้ แต่ cache อาจค้าง ถ้าเจอ 502 ลอง clear ก่อน
ติดอะไรทักใน #infra ได้เลย
EOF

cat > samples/forwarded-hr-notice.md <<'EOF'
(อันนี้ไม่ใช่ของผม คุณหน่อยฝ่าย HR เขียน ส่งต่อมาให้ดูเฉยๆ)

เรียน พนักงานทุกท่าน

ตามที่บริษัทจะดำเนินการปรับปรุงระบบลงเวลาทำงาน ในวันศุกร์ที่ 13 พฤศจิกายน 2569 เวลา 18.00 น. เป็นต้นไป ระบบอาจไม่สามารถใช้งานได้ชั่วคราว ขออภัยในความไม่สะดวกมา ณ โอกาสนี้

จึงเรียนมาเพื่อโปรดทราบ
EOF
