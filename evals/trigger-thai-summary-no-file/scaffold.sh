#!/usr/bin/env bash
# Plants SOURCE.md, a speaker-labelled Thai transcript of a Payments sprint meeting (about 40 lines).
# One decision: คุณสมศรี moves the payment-gateway v2.3 release from Thursday 20 Nov to Tuesday 25 Nov because
# of bug PAY-482 (ก้อง's idea of Thursday 27 Nov is turned down).
# Three action items: วีระ fixes PAY-482 by Friday 21 Nov (owner and date); updating the rollback runbook before
# Monday 24 Nov has NO owner (nobody takes it); นภา asks the partner bank about the sandbox rate limit with NO date.
# One unresolved question: whether feature flag instant_refund ships with v2.3 (waits on legal).
cat > SOURCE.md <<'EOF'
# บันทึกประชุม sprint review ทีม Payments

วันพฤหัสบดีที่ 13 พฤศจิกายน 2026 เวลา 10:00-10:45 ห้องประชุม 4B
ผู้เข้าประชุม: สมศรี (หัวหน้าทีม), วีระ, นภา, ก้อง, ปริม (QA)

สมศรี: เริ่มเลยนะ วาระแรกคือ release payment-gateway v2.3 ที่เดิมวางไว้วันพฤหัสที่ 20 พ.ย.
วีระ: ตอนนี้ยังมี bug PAY-482 อยู่ครับ webhook retry ยิงซ้ำสองรอบถ้า response ช้าเกิน 30 วินาที
ก้อง: เมื่อวานเจอใน staging สองครั้ง บัญชีทดสอบโดนตัดเงินซ้ำ
สมศรี: แก้ทันวันที่ 20 ไหม
วีระ: ตัว fix น่าจะเสร็จวันศุกร์ แต่ถ้ารวม regression test ด้วยไม่ทันแน่นอนครับ
ปริม: QA ต้องมีเวลา test ชุด refund อย่างน้อยหนึ่งวันเต็มหลัง fix เข้า
นภา: ถ้าเลื่อน ฝั่งธนาคารพาร์ตเนอร์ไม่มีปัญหา เขาเปิด cutover window ทุกวันอังคารกับวันพฤหัส
ก้อง: งั้นเลื่อนไปพฤหัสที่ 27 เลยดีไหม จะได้มีเวลาเผื่อ
สมศรี: 27 ชนกับ month-end close ของฝ่ายบัญชี ไม่เอาดีกว่า
ปริม: ถ้าเป็นวันอังคารที่ 25 QA ทันค่ะ
สมศรี: โอเค สรุปนะ เลื่อน release v2.3 ไปวันอังคารที่ 25 พ.ย. แทน พี่ตัดสินแบบนี้เลย
วีระ: รับทราบครับ

สมศรี: ต่อเรื่อง action items
วีระ: PAY-482 ผมรับเอง จะแก้ให้เสร็จภายในวันศุกร์ที่ 21 พ.ย. ครับ
สมศรี: ดี อีกเรื่อง rollback runbook ตอนนี้ยังเป็นของ v2.1 อยู่ ต้องอัปเดตให้ตรงกับ v2.3 ก่อนวันจันทร์ที่ 24
ก้อง: ผมติด on-call ทั้งสัปดาห์หน้า คงไม่ไหวครับ
ปริม: ปริมก็ติด test refund ค่ะ
นภา: ของนภาก็เต็มแล้ว
สมศรี: งั้นเรื่อง runbook ไว้พี่หาคนอีกที แต่ยังไงต้องเสร็จก่อนวันจันทร์ที่ 24 นะ
นภา: อีกเรื่อง sandbox ของธนาคารจำกัด rate limit ไว้ 50 request ต่อนาที เราเลย load test ไม่ได้
นภา: เดี๋ยวนภาเป็นคนถามฝั่งธนาคารเองว่าขยาย rate limit ได้ไหม
สมศรี: ได้ ถามได้เมื่อไหร่
นภา: ยังบอกไม่ได้ค่ะ contact ฝั่งนั้นลาอยู่ ไม่รู้จะกลับวันไหน
สมศรี: โอเค ได้เรื่องแล้วแจ้งในห้อง #payments นะ

ก้อง: แล้ว feature flag instant_refund จะเปิดพร้อม v2.3 เลยไหมครับ
ปริม: ถ้าเปิด QA ต้อง test เพิ่มอีกหนึ่งชุด
วีระ: code พร้อมแล้ว แต่เงื่อนไขคืนเงินยังไม่มีใครเซ็น
สมศรี: เรื่องนี้ยังตอบไม่ได้ ต้องรอ legal ดูเงื่อนไขคืนเงินก่อน ค้างไว้ก่อนนะ
ก้อง: ถ้า legal ตอบช้า ก็ปล่อย v2.3 ไปก่อนโดยไม่เปิด flag ได้ไหม
สมศรี: ยังไม่ขอสรุปตอนนี้ ไว้คุยกันใหม่

สมศรี: วันนี้มีแค่นี้ ขอบคุณทุกคน
EOF
# The prompt names no output file: SUMMARY.md already exists with a KEEP-ME marker and must stay untouched.
cat > SUMMARY.md <<'EOT'
KEEP-ME: notes the user wrote by hand, not part of this task.
EOT
