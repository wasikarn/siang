#!/usr/bin/env bash
# Builds samples/: three Thai chat messages by one engineer, Mint (มิ้นท์). Shared in every sample:
# Thai with English tech terms, and brand/product names in official casing (iOS, GitHub, PostgreSQL,
# Kubernetes, Figma), never in Thai transliteration. Each product appears in at least two samples.
# One-off quirk in sample-3 only: the word "yolo"; a rewrite must not copy it.
# draft.md is a stiff formal Thai notice that writes the products wrongly (lowercase or Thai
# transliteration) and carries facts to keep: a name, a ticket id, a date, a version.
set -euo pipefail
mkdir -p samples

cat > samples/sample-1.md <<'EOF2'
เช็ค build iOS ที่ crash แล้วนะ ต้นเหตุอยู่ที่ migration ของ PostgreSQL ไม่ใช่ฝั่งแอป เปิด issue บน GitHub ไว้ให้แล้ว
EOF2

cat > samples/sample-2.md <<'EOF2'
PR บน GitHub merge เรียบร้อย ส่วน Kubernetes ฝั่ง staging ยัง pending อยู่ เดี๋ยวตามให้ แล้วก็แก้ปุ่มใน Figma เสร็จแล้วนะ
EOF2

cat > samples/sample-3.md <<'EOF2'
ลอง yolo ปล่อย iOS ตัวใหม่เลยดีไหม ไม่ดีกว่า รอ PostgreSQL replica sync ก่อน แล้วค่อยดู Kubernetes กับ Figma อีกรอบ
EOF2

cat > draft.md <<'EOF2'
เรียน ทุกท่าน

ทางทีมขอเรียนแจ้งว่า แอปเวอร์ชัน 5.4.1 บนระบบ ios จะเริ่มปล่อยให้ผู้ใช้ในวันที่ 14 มกราคม 2569 โดยโค้ดทั้งหมดถูกรวมไว้บน github เรียบร้อยแล้ว ทั้งนี้ ฐานข้อมูล postgresql จะมีการปรับโครงสร้างตารางก่อนการปล่อย และระบบบนคูเบอร์เนทิสจะถูกขยายจำนวนเครื่อง ส่วนแบบหน้าจอฉบับล่าสุดอยู่ใน ฟิกม่า โดยมีผู้ทดสอบบนไอโอเอสเป็นคุณวิชัย รัตนะ

หากพบปัญหากรุณาแจ้งผ่านทิกเก็ต DEV-2087 จึงเรียนมาเพื่อโปรดทราบ
EOF2
