# Thai summary template
A fixed summary shape kept as a plain doc, not a skill: no blind A/B has shown a skill beats a template for this (`evals/README.md`). Read it into a session, or paste the template, when you want a summary in this shape. Every summary has the same five sections in the same order, so a reader always finds the same thing in the same place.
Shape follows BLUF / Minto: the answer first, then 2-4 supporting points, then what was decided and what happens next.
## Template
```markdown
## ข้อสรุป
<1-3 บรรทัด: คำตอบหรือผลลัพธ์สำคัญที่สุด>

## ประเด็นหลัก
- <2-4 ข้อ ข้อละประโยคเดียว>

## การตัดสินใจ
- <สิ่งที่ตกลงกัน และใครเป็นคนตัดสิน> หรือ "ไม่มี"

## สิ่งที่ต้องทำต่อ
- <ใคร> — <ทำอะไร> — <เมื่อไหร่> หรือ "ไม่มี"

## ที่ยังค้าง
- <คำถามหรือเรื่องที่ยังไม่ชัด> หรือ "ไม่มี"
```
## Rules
1. All five sections appear every time, in this order, with these exact headings. A section with nothing to say holds the single word `ไม่มี`. Never drop a heading, add one or rename one.
2. Lead with the conclusion. Do not open with background or "เอกสารนี้พูดถึง".
3. Key points: 2-4 bullets, one sentence each.
4. Each action item has three parts: who, what, when. When the source gives no owner or date, write `ไม่ระบุ`; never invent one.
5. Say only what the source says. A claim you cannot trace to the source goes under `ที่ยังค้าง` as a question.
6. Length: at most 1500 non-space characters (about 500 English words). Longer sources get a longer source, not a longer summary.
7. Technical terms stay in English; the sentences around them are Thai. Run `skills/humanize/scripts/scan.py` on the result and read every hit.
## Check
`python3 ~/Codes/Personals/siang/docs/thai-summary/summary_check.py SUMMARY.md` (works from any folder) prints JSON findings and exits 1 when the summary breaks rules 1, 3, 4 or 6. It cannot judge rules 2, 5 or 7; read those yourself.
## Example
```markdown
## ข้อสรุป
ทีมตกลงเลื่อน release v2 ไปสัปดาห์หน้า เพราะ migration ของฐานข้อมูลยังไม่ผ่านการทดสอบ

## ประเด็นหลัก
- migration ล้มเหลวบน staging 2 ครั้งจาก 3 ครั้ง
- ลูกค้า 1 รายรอฟีเจอร์ export แต่ยอมรอได้
- ทีม QA ต้องการเวลาเพิ่มอีก 3 วันเพื่อ regression test

## การตัดสินใจ
- เลื่อน release จากวันศุกร์ไปวันศุกร์หน้า (ตัดสินใจโดยหัวหน้าทีม)

## สิ่งที่ต้องทำต่อ
- สมชาย — แก้ migration script และรันบน staging ซ้ำ — วันพุธ
- มาลี — แจ้งลูกค้าเรื่องวันใหม่ — วันนี้
- ทีม QA — เริ่ม regression test — ไม่ระบุ

## ที่ยังค้าง
- สาเหตุที่ migration ล้มเหลวครั้งที่สองยังไม่ชัดเจน
```
