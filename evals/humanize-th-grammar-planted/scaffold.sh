#!/usr/bin/env bash
cat > pr.md <<'FIXTURE_EOF'
## สรุป

ย้าย image resize ออกจาก `api-server` ไปเป็น `resize-worker` แยก เพราะตอนนี้ request ของ API จะช้าลงเกือบเท่าตัวเมื่อมีคนอัปโหลดรูปพร้อมกันเยอะ

PR นี้ไม่ได้ย้าย resize อย่างเดียว เปลี่ยน cache key ของรูปให้ใช้ hash ของไฟล์แทน hostname ของ pod

## ก่อน merge

ต้องสร้าง VM ใหม่ 3 ใบให้ worker บน staging ส่วน production ยังไม่ต้องทำ รอดูผลบน staging หนึ่งสัปดาห์ก่อน
FIXTURE_EOF
