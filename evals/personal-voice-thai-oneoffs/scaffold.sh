#!/usr/bin/env bash
mkdir -p samples
: > voice.md
printf 'แก้เสร็จแล้วนะ กำลังเช็ค staging อยู่\n' > samples/1.txt
printf 'api ช้าอีกแล้ว 😅 ดู db อยู่นะ\n' > samples/2.txt
printf 'rollback แล้ว เดี๋ยวลองใหม่หลังกินข้าวนะ!!!\n' > samples/3.txt
cat > draft.md <<'FIXTURE_EOF'
เรียนทุกท่าน! การ deploy ในวันนี้ล่าช้า เนื่องจาก migration ติด lock ขออภัยในความไม่สะดวก คาดว่าจะดำเนินการแล้วเสร็จพรุ่งนี้ เวลา 10.00 น. หากมีข้อสงสัยสามารถสอบถามได้ครับ 😊
FIXTURE_EOF
