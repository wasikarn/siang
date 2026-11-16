#!/usr/bin/env bash
# Plants SOURCE.md, a ~120-line Thai/English postmortem and follow-up plan for INC-2041 (checkout down 38 minutes),
# dense enough that a summary keeping every detail runs past 1500 non-space characters.
# Facts: INC-2041, 3 Nov 2026 19:42-20:20, 38 minutes, 1,240 failed orders (about 2.3 million baht), root cause
# db.max_pool_size cut from 50 to 15 in order-service without review.
# Decisions (three, by คุณอรุณ, the third with คุณมาลี): keep the pool at 50 and change it only after a load test;
# every config change on the checkout path needs PR review; freeze checkout-path deploys until Thursday 20 Nov
# except hotfixes. A rejected option (roll back HikariCP) is discussion, not a decision.
# Action items: five; #3 (load test at 2x peak, due 19 Nov) has NO owner, #4 (export the failed orders for CS,
# owner คุณธนา) has NO date.
# Open: whether to compensate customers with a coupon; why the existing latency alert never fired.
cat > SOURCE.md <<'EOF'
# Postmortem และแผนต่อ: INC-2041 checkout ใช้งานไม่ได้ 38 นาที

สถานะเอกสาร: final หลังประชุม postmortem วันพุธที่ 12 พฤศจิกายน 2026
ผู้เขียน: คุณพิชิต (SRE, on-call คืนนั้น)
ผู้เข้าร่วม review: คุณอรุณ (CTO), คุณมาลี (Tech Lead ทีม Checkout), คุณธนา (Engineering Manager ทีม Order),
คุณพิชิต, คุณเจน (QA Lead), คุณบอส (Platform)

## 1. สรุปเหตุการณ์

วันจันทร์ที่ 3 พฤศจิกายน 2026 เวลา 19:42 ถึง 20:20 รวม 38 นาที ลูกค้ากดชำระเงินในหน้า checkout ไม่สำเร็จ
หน้าเว็บขึ้น "ระบบขัดข้อง กรุณาลองใหม่" ส่วน mobile app ค้างที่ spinner จน timeout
order ที่ fail ทั้งหมด 1,240 รายการ มูลค่ารวมประมาณ 2.3 ล้านบาท
ไม่มีข้อมูลเสียหายและไม่มีการตัดเงินซ้ำ ยืนยันจาก reconciliation ของ payment provider แล้ว

ต้นเหตุ: config change ใน order-service ที่ลด `db.max_pool_size` จาก 50 เหลือ 15
config นี้ถูก merge ตรงเข้า branch config-prod เวลา 19:30 โดยไม่ผ่าน review
เจตนาเดิมคือลด connection ที่ค้างไปยัง read replica แต่ค่าเดียวกันคุม pool ของ primary ด้วย
พอ traffic ช่วงหัวค่ำขึ้น pool เต็ม request ที่รอ connection เกิน 30 วินาทีก็ timeout ทั้งหมด

## 2. Timeline (เวลาไทย)

- 19:30 merge config change `db.max_pool_size: 50 -> 15` เข้า config-prod, Argo sync อัตโนมัติ
- 19:33 order-service ทุก pod restart ด้วย config ใหม่ครบ
- 19:38 p99 latency ของ `POST /orders` ขึ้นจาก 420 ms เป็น 6.8 s
- 19:42 error rate 5xx ของ checkout เกิน 40%
- 19:44 alert `checkout_5xx_rate` fire เข้า PagerDuty
- 19:51 คุณพิชิต ack alert (ช้าไป 7 นาทีเพราะอยู่ระหว่างเดินทาง)
- 19:58 เปิด incident channel #inc-2041 ดึงคุณมาลีกับคุณบอสเข้ามา
- 20:03 สงสัย payment provider ก่อน ตรวจ status page ของ provider แล้วปกติ
- 20:09 คุณบอสเห็น log `Connection is not available` เต็ม order-service
- 20:12 พบ config change ใน git log ของ config-prod
- 20:14 revert config กลับเป็น 50, Argo sync
- 20:17 pod ใหม่ขึ้นครบ error rate เริ่มลด
- 20:20 error rate กลับต่ำกว่า 0.5% ถือว่า recovered
- 20:45 ปิด incident channel แจ้งทีม CS ให้ตอบลูกค้าตาม template

## 3. Log และ metric ที่เกี่ยวข้อง

```
2026-11-03T12:42:11Z ERROR order-service [http-nio-8080-exec-87] HikariPool-1 - Connection is not available, request timed out after 30000ms
2026-11-03T12:42:11Z ERROR order-service [http-nio-8080-exec-91] HikariPool-1 - Connection is not available, request timed out after 30000ms
2026-11-03T12:42:13Z WARN  order-service HikariPool-1 - Pool stats (total=15, active=15, idle=0, waiting=212)
2026-11-03T12:44:02Z ERROR checkout-bff  upstream order-service returned 503 for POST /orders (trace=7f3a9c)
```

- `hikaricp_connections_active` แตะ 15/15 ตั้งแต่ 19:37 จนถึง 20:15
- `hikaricp_connections_pending` สูงสุด 212
- CPU ของ database ไม่เกิน 35% ตลอดช่วง แปลว่า database ไม่ได้เป็นคอขวด
- ไม่มี panel pool usage ใน dashboard checkout ทำให้ต้องเปิด log ไล่เอง

## 4. วิเคราะห์ต้นเหตุ (5 whys)

1. ทำไม checkout fail: order-service ตอบ 503 เพราะรอ DB connection เกิน 30 วินาที
2. ทำไมรอ connection: pool มีแค่ 15 connection แต่ช่วง peak ต้องใช้ราว 40
3. ทำไม pool เหลือ 15: มี config change ลดค่าเพื่อแก้ปัญหา connection ค้างที่ read replica
4. ทำไมค่าเดียวคุมทั้ง primary และ replica: config ของ order-service ใช้ key เดียวกันมาตั้งแต่ปี 2024
5. ทำไมไม่มีใครเห็นก่อน merge: branch config-prod ไม่บังคับ review และไม่มี load test สำหรับ config

## 5. สิ่งที่ทำได้ดี

- revert ได้ภายใน 2 นาทีหลังเจอต้นเหตุ เพราะ config อยู่ใน git
- reconciliation ยืนยันได้เร็วว่าไม่มีการตัดเงินซ้ำ
- ทีม CS ได้ template ตอบลูกค้าภายใน 30 นาทีหลัง recovered

## 6. สิ่งที่ทำได้ไม่ดี

- alert latency ที่มีอยู่ (`checkout_p99_latency > 3s`) ไม่ fire เลย ทั้งที่ p99 ขึ้นไป 6.8 s
- on-call ack ช้า 7 นาที
- ใช้เวลา 11 นาทีไล่ดู payment provider ก่อน เพราะเคยเป็นต้นเหตุครั้งก่อน
- ไม่มี metric pool ใน dashboard

## 7. การหารือในที่ประชุม

คุณบอสเสนอให้ rollback HikariCP กลับไป version เก่าเผื่อมี bug
คุณมาลีแย้งว่า log ชัดเจนว่า pool เต็มตาม config ไม่ใช่ bug ของ library ที่ประชุมจึงไม่ทำตามข้อเสนอนี้
คุณเจนถามว่าควรมี load test ก่อนปลด freeze ไหม ทุกคนเห็นด้วยว่าควรมี แต่ยังไม่มีใครรับเป็นเจ้าของ
คุณธนาเล่าว่าทีม CS ขอรายชื่อ order ที่ fail เพื่อโทรหาลูกค้า คุณธนารับไปทำ แต่ยังไม่ได้กำหนดวัน
มีคนถามว่าจะชดเชยลูกค้าด้วย coupon ไหม คุณอรุณบอกว่าต้องรอฝ่าย business ประเมินต้นทุนก่อน วันนี้ยังไม่ตัดสิน
คุณพิชิตถามว่าทำไม alert latency ไม่ fire ยังไม่มีใครตอบได้ ต้องไล่ดู rule ใน Prometheus อีกที

## 8. การตัดสินใจ

1. คง `db.max_pool_size` ไว้ที่ 50 (revert แล้วตั้งแต่ 3 พ.ย.) ห้ามเปลี่ยนค่านี้โดยไม่มี load test รองรับ คุณอรุณเป็นผู้ตัดสิน
2. config change ทุกตัวของ service ใน checkout path ต้องผ่าน PR review อย่างน้อย 1 คน มีผลทันที คุณอรุณเป็นผู้ตัดสิน
3. freeze deploy ของ service ใน checkout path จนถึงวันพฤหัสบดีที่ 20 พ.ย. ยกเว้น hotfix คุณอรุณกับคุณมาลีตกลงร่วมกัน

## 9. Action items

| # | งาน | เจ้าของ | กำหนด |
|---|-----|--------|-------|
| 1 | เพิ่ม alert `db_pool_saturation` เมื่อ pool ใช้เกิน 80% นาน 2 นาที | คุณพิชิต | 14 พ.ย. |
| 2 | เขียน config review policy ลง `CONTRIBUTING.md` ของ repo config-prod | คุณมาลี | 18 พ.ย. |
| 3 | load test checkout ที่ 2 เท่าของ peak traffic ก่อนปลด freeze | ยังไม่มีเจ้าของ | 19 พ.ย. |
| 4 | export รายการ order ที่ fail ทั้ง 1,240 รายการส่งให้ทีม CS | คุณธนา | ยังไม่กำหนด |
| 5 | เพิ่ม panel pool usage ใน Grafana dashboard ของ checkout | คุณบอส | 14 พ.ย. |

## 10. คำถามที่ยังเปิด

- จะชดเชยลูกค้าที่ได้รับผลกระทบด้วย coupon หรือไม่ รอฝ่าย business ประเมิน
- ทำไม alert `checkout_p99_latency` ไม่ fire ทั้งที่ค่าเกิน threshold
- ควรแยก config pool ของ primary กับ replica ออกจากกันไหม ยังไม่มีใครเสนอแผน

## 11. ภาคผนวก: config ก่อนและหลัง

```yaml
# ก่อน (ค่าที่ใช้มาตั้งแต่ 2024)
db:
  max_pool_size: 50
  connection_timeout_ms: 30000
# ที่ถูก merge เวลา 19:30
db:
  max_pool_size: 15
  connection_timeout_ms: 30000
```

เอกสารนี้จะอัปเดตอีกครั้งเมื่อ action items ปิดครบ
EOF
