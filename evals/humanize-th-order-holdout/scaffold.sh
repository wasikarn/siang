#!/usr/bin/env bash
cat > handoff.md <<'FIXTURE_EOF'
ส่งเวร on-call ต่อให้ @ploy นะครับ ตอนนี้ payment-gateway กลับมาปกติแล้ว แต่ INC-4821 ยังเปิดอยู่
สาเหตุคือ connection pool ของ Redis เต็มตอน 14:20 เลย timeout ไปประมาณ 25 นาที
restart pod payment-gateway ได้เลยนะครับหาก p99 latency เกิน 800ms ติดกันเกิน 5 นาที
ช่วย page พี่ต้นด้วยครับเมื่อ error rate ของ /v2/charge ขึ้นเกิน 2%
ค่อยเปิด feature flag new-checkout กลับนะครับหลังจากที่ hotfix PR #312 deploy ขึ้น prod แล้ว
พรุ่งนี้ 10:00 ผมจะเข้ามาเขียน postmortem ต่อครับ
FIXTURE_EOF
