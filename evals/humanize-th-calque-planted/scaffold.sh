#!/usr/bin/env bash
cat > incident.md <<'FIXTURE_EOF'
อัปเดต incident เมื่อคืน

- ระบบล้มตอน 23:10 เพราะ connection pool ของ `order-db` เต็ม ตอนนี้กลับมาปกติแล้ว
- PR #412 ที่แก้ pool size ถือไว้ก่อน รอพี่บอย review
- ขอหน้าต่างเวลาคืนวันพฤหัส 22:00-23:00 สำหรับ deploy ตัวแก้ ถ้าไม่ได้ช่วงนี้จะเลื่อนไปคืนวันเสาร์
- ระหว่างนี้ให้ทุกคนงด run batch report บน production
FIXTURE_EOF
