---
name: thai-summary
description: "Write a summary in Thai in one fixed five-section shape. Use when asked to summarize a meeting, document or work session in Thai: 'สรุป', 'สรุปที่คุยกัน', 'สรุปงานที่ทำ'."
---
# Thai summary
A requested summary takes the same five sections in the same order every time, so a reader finds the same thing in the same place. A closing recap at the end of an ordinary reply is not a requested summary.
## The loop
1. **Read** the source end to end.
2. **Write** the summary (to the file the user named, else `SUMMARY.md`) in exactly this shape:
```markdown
## ข้อสรุป
<1-3 บรรทัด: ผลลัพธ์ที่ผู้อ่านต้องรู้มากที่สุด>

## ประเด็นหลัก
- <2-4 ข้อ ข้อละประโยคเดียว>

## การตัดสินใจ
- <สิ่งที่ตกลงกัน และใครตัดสิน> หรือ "ไม่มี"

## สิ่งที่ต้องทำต่อ
- <ใคร> — <ทำอะไร> — <เมื่อไหร่> หรือ "ไม่มี"

## ที่ยังค้าง
- <คำถามหรือเรื่องที่ยังไม่ชัด> หรือ "ไม่มี"
```
   - All five sections appear every time with these exact headings; a section with nothing to say holds the single word `ไม่มี`.
   - Open with the conclusion.
   - Write `ไม่ระบุ` for an owner or date the source leaves out.
   - Every claim traces to the source; whatever the source leaves unclear goes under `ที่ยังค้าง` as a question.
   - Keep dates and quoted words exactly as the source writes them.
   - At most 1500 non-space characters. Technical terms stay in English; the sentences around them are Thai.
3. **Check.** Run `python3 ${CLAUDE_SKILL_DIR}/scripts/summary_check.py <file>` and fix every finding. Then run `python3 ${CLAUDE_PLUGIN_ROOT}/skills/humanize/scripts/scan.py <file>` and read every hit.
   Done when: the checker prints no findings and you have read each scan hit.
The checker covers headings, order, empty sections, key-point count, action shape and length. It cannot judge rules about the source or wording: read those yourself.
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
