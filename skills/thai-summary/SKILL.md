---
name: thai-summary
description: "Summarize a meeting, document or work session in Thai (สรุป), in one fixed five-section shape. Use when the user asks for such a summary."
---
# Thai summary
A requested summary takes the same five sections in the same order every time, so a reader finds the same thing in the same place. A request for one sentence or another explicit length or format gets exactly that, outside this shape, and step 3 does not apply. A closing recap at the end of an ordinary reply is not a requested summary.
## The loop
1. **Read** the source end to end.
2. **Write** the summary where the user asked: the file they named, else the reply. Create or overwrite no file the user did not name. A named file that already holds other content gets the summary added; leave the rest as it is. Use exactly this shape:
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
   - At most 1500 non-space characters. Technical terms stay in English; the sentences around them are Thai.
3. **Check.** Check the summary text alone: when the file holds only the summary, run `python3 "${CLAUDE_SKILL_DIR}/scripts/summary_check.py" <file>`; otherwise (a reply, or a file with other content) pipe the text in with a quoted heredoc, `python3 "${CLAUDE_SKILL_DIR}/scripts/summary_check.py" - <<'EOF'`, so the source's text never reaches the shell. Fix every finding. Then run `python3 "${CLAUDE_PLUGIN_ROOT}/skills/humanize/scripts/scan.py"` the same way (`<file>` or `-`) and read every hit. The ` — ` separators in action items belong to the template, so the scan's em-dash hits on those lines are expected; read the other hits.
   Done when: the checker prints no findings and you have read each other scan hit.
The checker covers headings, order, empty sections, key-point count, action shape and length, on the text you give it, not on the rest of a reply or file. It cannot judge rules about the source or wording: read those yourself.
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
