#!/usr/bin/env bash
# Builds samples/: three Thai team-chat messages by one engineer, Ton (ต้น). Shared in every sample:
# opens with "fyi", the particle ฮะ (never ครับ), English tech terms in Latin script (deploy, rollback,
# PR, config) instead of Thai transliteration, no exclamation marks, no emoji, short.
# One-off quirk in sample-2 only: the laugh "5555"; a rewrite must not copy it.
# draft.md is a stiff formal Thai announcement to rewrite in place, keeping every fact.
set -euo pipefail
mkdir -p samples

cat > samples/sample-1.md <<'EOF'
fyi deploy staging เสร็จแล้วฮะ ใคร test login แล้วเจอ error ทักมาได้เลย เดี๋ยวดูให้
EOF

cat > samples/sample-2.md <<'EOF'
fyi พรุ่งนี้ผม off ครึ่งวันฮะ PR ที่ค้างอยู่ฝากพี่บอส review ก่อนนะ 5555 ขอโทษที่ดองไว้นาน
EOF

cat > samples/sample-3.md <<'EOF'
fyi rollback ตัว payment ไปแล้วฮะ ต้นเหตุคือ config timeout ผิด รายละเอียดอยู่ใน PAY-88 ใครเจออาการเดิมแจ้งในเธรดนี้ได้เลย
EOF

cat > draft.md <<'EOF'
เรียน ทุกท่าน

ทางทีมพัฒนาระบบขอเรียนแจ้งให้ทราบว่า จะมีการดีพลอยระบบ Notification เวอร์ชัน 3.2 ขึ้นสู่เซิร์ฟเวอร์ Production ในวันศุกร์ที่ 22 พฤศจิกายน 2567 เวลา 20:00 น. โดยคาดว่าระบบจะไม่สามารถใช้งานได้เป็นระยะเวลาประมาณ 15 นาที

ทั้งนี้ คุณสมชาย ใจดี จะเป็นผู้รับผิดชอบในการดำเนินการดังกล่าว หากพบปัญหาภายหลังการดีพลอย กรุณาแจ้งผ่านทิกเก็ต NOTI-341

จึงเรียนมาเพื่อโปรดทราบ และขออภัยในความไม่สะดวกมา ณ โอกาสนี้ครับ
EOF
