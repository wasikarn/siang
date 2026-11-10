#!/usr/bin/env bash
cat > pr.md <<'FIXTURE_EOF'
## PR #412: ย้าย session store จาก memory ไป Redis

### ปัญหา
ตอนนี้ session เก็บอยู่ใน memory ของแต่ละ pod user จะโดน logout ถ้า pod ถูก evict หรือ scale down สัปดาห์ที่แล้ว support ได้ ticket เรื่องนี้ 23 ใบ

### สิ่งที่แก้
- เพิ่ม `RedisSessionStore` มาแทน `MemorySessionStore`
- TTL ของ session ยัง 8 ชั่วโมงเท่าเดิม
- อ่าน `REDIS_URL` จาก env

### ข้อควรระวัง
- ต้อง restart `auth-api` ทุกครั้งหลัง `REDIS_URL` เปลี่ยน เพราะ client ไม่อ่านค่าใหม่เอง
- deploy รอบนี้ session เดิมใน memory จะหายหมด user ทุกคนต้อง login ใหม่หนึ่งครั้ง

### ทดสอบ
ยิง load test บน staging 2,000 RPS นาน 15 นาที ไม่มี session หลุดเลย
FIXTURE_EOF
