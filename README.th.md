# siang (เสียง)

**skill สำหรับ Claude Code ที่ช่วยให้งานเขียนสาย dev อ่านแล้วเหมือนคนเขียนจริง**

[English](README.md)

> ข้อความจาก AI มีกลิ่น

standup ที่เปิดว่า "ยินดีที่จะแจ้งให้ทราบ" คำอธิบาย PR ที่มีสามข้อยาวเท่ากันเป๊ะ ประกาศภาษาไทยที่ลงท้ายครับ
ทุกประโยคแล้วต่อด้วย "ซึ่ง" กับ "โดย" คนอ่านรู้ตั้งแต่บรรทัดแรก แล้วก็เลิกเชื่อส่วนที่เหลือ

siang เป็น plugin ของ Claude Code ที่เอากลิ่นนี้ออกทั้งภาษาอังกฤษ ภาษาไทย และไทยปนอังกฤษ
กับมีอีกสามงานที่อยู่ใกล้กัน คือเขียนเอกสารที่คนตามได้ ตรวจเอกสารเทียบกับมาตรฐาน และเขียนด้วยเสียงของตัวเอง
เสียง แปลว่า voice

## เหมาะกับใคร

- developer ที่ให้ AI ร่าง chat, standup, PR, commit, ข้อความใน UI, ADR หรือ README ทั้งไทยและอังกฤษ
- ทีมที่ได้ output ภาษาไทยจาก AI แล้วอ่านเหมือนงานแปล
- ใครที่เคยวาง draft แล้วคิดว่า "นี่มันเสียง AI"

## ติดตั้ง

```bash
claude plugin marketplace add wasikarn/siang
claude plugin install siang@siang
```

## ห้า skill

| Skill | ใช้เมื่อ | ทำอะไร |
|---|---|---|
| `siang:humanize` | draft อ่านแล้วเหมือน AI เขียน | ไล่หา AI tell ทุกจุดจาก cue sheet แล้วเขียนใหม่ จากนั้นอ่านซ้ำหาส่วนที่ยังเหลือ |
| `siang:technical-writing` | ต้องการ how-to, tutorial, หน้า reference, runbook หรือ README | เลือก Diátaxis หนึ่งแบบต่อเอกสาร เอาข้อเท็จจริงจากโค้ดและคำสั่งที่รันเอง ส่วนที่ยังไม่ได้ตรวจใส่ `TODO: verify` |
| `siang:document-review` | เอกสารต้องตรงตามมาตรฐาน (SOP, runbook, policy, spec) | แยก claim ออกมา ตรวจความแม่นยำ ตรรกะ การสืบย้อน และความสอดคล้อง ได้ ledger ที่จัดเกรดกับ verdict |
| `siang:thai-pua-repair` | ข้อความที่ extract จาก PDF ไทยมีอักขระ private-use หรือวรรณยุกต์เพี้ยน | แปลง glyph ของฟอนต์ UPC บน Windows 27 ตัว (U+F700..U+F71A) กลับเป็นอักษรไทยมาตรฐาน รายงานตัวที่แปลงไม่ได้ และเมื่อสั่งจะแก้ ToUnicode map ในไฟล์ PDF เอง ให้ copy และค้นหาได้ถูก (`pua_pdf.py` ต้องมี pikepdf) |
| `siang:personal-voice` | อยากได้ draft ด้วยเสียงของตัวเอง | วัดจากตัวอย่างของคุณ เก็บลักษณะที่ปรากฏอย่างน้อยสองตัวอย่าง เขียนจากข้อเท็จจริงของคุณ แล้วเทียบ draft กับ profile |

เรียกด้วย slash command (`/siang:humanize`) หรือสั่งเป็นประโยคก็ได้ ตัวอย่าง prompt:

```
humanize standup update นี้ genre B เก็บตัวเลขทุกตัว
```

```
ใช้ siang:technical-writing เขียน docs/deploy.md ใหม่ให้ on-call engineer
```

```
ใช้ siang:document-review ตรวจ sop-restore.md เทียบกับ standard.md แค่รีวิว ไม่ต้องแก้
```

```
ใช้ siang:personal-voice: samples/ คือข้อความของฉัน เขียน draft.md ใหม่ให้เหมือนฉัน
```

## `humanize` ทำงานยังไง

วนตามลำดับนี้

1. เลือก genre (A chat, B standup/PR/commit, C ข้อความ UI/error, D บทความ/blog/ADR) และภาษา
2. วางแผน grit คือรายละเอียดเฉพาะจากต้นฉบับที่ฉบับเขียนใหม่ต้องเก็บไว้
3. ไล่หา AI tell ทุกจุดจาก cue sheet 33 แถว บวก pattern เฉพาะภาษาไทยถ้ามีข้อความไทย
   `scripts/scan.py` รันก่อนและแสดง tell ที่ pattern จับได้ (em dash, คำสาย AI, ประโยคปิดแบบ chat,
   การสะกดและรูปแบบวันที่ภาษาไทย) พร้อมเลขบรรทัดและเลข § แล้วโมเดลตัดสินทีละจุดและอ่านหาที่เหลือ
4. เขียน draft ถามตัวเองว่า "ตรงไหนยังเหมือน AI" แล้วเขียนฉบับสุดท้าย

สองกฎที่ใช้ตลอด ไม่แต่งข้อเท็จจริงเพิ่ม (claim ที่ตรวจไม่ได้ตัดทิ้งหรือลดน้ำหนัก ไม่เดาให้) และถ้าเป็นไฟล์
จะแก้เฉพาะร้อยแก้ว code block, คำสั่ง, frontmatter และข้อความอ้างอิงต้องเหมือนเดิมทุก byte

## โครงสร้าง repo

| path | เนื้อหา |
|---|---|
| `skills/humanize/` | `SKILL.md`, cue sheet, pattern สากลและไทย, โครงสร้างประโยคไทย, ตัวอย่าง, แหล่งอ้างอิง, `scripts/scan.py` |
| `skills/technical-writing/` | `SKILL.md` |
| `skills/document-review/` | `SKILL.md` |
| `skills/personal-voice/` | `SKILL.md` |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `evals/` | 27 เคสในรูปแบบของ `claude plugin eval` อธิบายใน `evals/README.md` |
| `tests/` | เช็กฟรีที่ CI รันทุก push: grader self-test, hook เช็ก version, ทุก § และ cue ต้องหาเจอ, `scan.py` จับ tell ที่ใส่ไว้ได้ |

## Eval

แต่ละเคสรันสองรอบ คือมี siang และไม่มี siang ตัวเลขที่ควรดูคือส่วนต่าง (Δ) ไม่ใช่คะแนนรวม
เพราะ Claude เปล่า ๆ ก็ได้คะแนนสูงในหลายเคส

- 18 เคสของ `humanize` ทั้งไทยและอังกฤษ หลายเคสเป็น regression guard ที่ Claude เปล่า ๆ ก็ผ่าน
  หน้าที่ของมันคือจับตอนที่ siang แพ้
- 9 เคสของอีกสี่ skill รันเคสละ 3 รอบต่อฝั่ง `document-review` 1.00 เทียบ 0.62 (Δ +0.38) และ
  `personal-voice` 1.00 เทียบ 0.78 กับ 1.00 เทียบ 0.70 (Δ +0.22 และ +0.30) ผลคงที่ ส่วนที่เหลือเล็กหรือเป็นศูนย์:
  `technical-writing` Δ +0.10 ในเคสที่ยากที่สุด และ 0.00 ในสองเคสที่ง่ายกว่า, `thai-pua-repair` Δ +0.08 ในเคส PDF
  บีบอัด และ 0.00 ในอีกสองเคส Claude เปล่า ๆ ทำสิ่งที่สอง skill นั้นขอได้เกือบหมด ที่ skill เพิ่มให้คือของที่ model เปล่าทิ้ง
  (claim ที่ยังไม่ได้ตรวจ, glyph ที่แปลงไม่ได้)

เช็กฟรีโดยไม่เรียก API: `bash tests/test-graders.sh` ส่วนรันจริง (เสียเงิน) คือ
`claude plugin eval . --scaffold --tag humanize --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
(เปลี่ยน tag เป็น `technical-writing`, `document-review`, `personal-voice` หรือ `thai-pua-repair`)

## เครดิตและ license

ที่มาของความรู้และ license อยู่ใน [README.md](README.md#credits) กับ
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) license ของ repo นี้คือ MIT ดู [LICENSE](LICENSE)
