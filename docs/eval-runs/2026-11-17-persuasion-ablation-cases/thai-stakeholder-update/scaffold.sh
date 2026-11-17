#!/usr/bin/env bash
# Plants STATUS.md (Thai/English engineering notes) for the branch-appointment go-live delay.
# Facts only the fixture holds: planned go-live Tue 24 Nov; new date Fri 27 Nov (3 days later);
# OTP SMS failed for 18% of tries in UAT after the SMS vendor changed its API; fix ready, needs 3 days re-test;
# 9 of 11 features passed UAT; no extra cost; answer needed by Fri 20 Nov to tell the branches.
cat > STATUS.md <<'EOF'
# ระบบนัดหมายสาขา: สถานะ (notes ของทีม dev)

- Go-live เดิม: อังคาร 24 พ.ย.
- UAT: ผ่านแล้ว 9 จาก 11 feature
- ปัญหา: vendor SMS เปลี่ยน API เมื่อสัปดาห์ที่แล้ว ทำให้ส่ง OTP ไม่สำเร็จ 18% ของครั้งที่ลองใน UAT
  (ลูกค้าประมาณ 1 ใน 5 จะไม่ได้รับรหัสยืนยันตอนจองคิว)
- Fix: แก้ code เสร็จแล้ว ต้อง re-test ใน UAT อีก 3 วันทำการ
- ถ้า go-live ตามเดิม: ลูกค้าส่วนหนึ่งจองคิวไม่ได้ พนักงานสาขาต้องจองให้แทนเอง
- ข้อเสนอ: เลื่อน go-live เป็น ศุกร์ 27 พ.ย. (ช้าไป 3 วัน)
- ค่าใช้จ่ายเพิ่ม: ไม่มี
- ต้องการคำตอบภายใน ศุกร์ 20 พ.ย. เพื่อแจ้งสาขาทั้งหมดล่วงหน้า
EOF
