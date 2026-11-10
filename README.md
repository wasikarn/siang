# siang (เสียง)

**skill สำหรับ Claude Code ที่ซ่อมข้อความจาก PDF ไทย และเอกสารอ้างอิงสำหรับเขียนด้วยเสียงของคุณเองกับเอากลิ่น AI ออกจากงานเขียน**

[English](README.en.md)

> ข้อความจาก AI มีกลิ่น

standup ที่เปิดว่า "ยินดีที่จะแจ้งให้ทราบ" คำอธิบาย PR ที่มีสามข้อยาวเท่ากันเป๊ะ ประกาศภาษาไทยที่ลงท้ายครับ
ทุกประโยค แถมใช้ "ซึ่ง" กับ "โดย" เต็มไปหมด คนอ่านรู้ตั้งแต่บรรทัดแรก แล้วก็เลิกเชื่อส่วนที่เหลือ

siang เป็น plugin ของ Claude Code ที่มี skill 5 ตัว: ซ่อมข้อความที่ดึงจาก PDF ไทยแล้วเพี้ยน (`thai-pua-repair`), เอากลิ่นนี้ออกทั้งภาษาอังกฤษ ภาษาไทย และไทยปนอังกฤษ (`humanize`),
เขียนด้วยเสียงของคุณเอง (`personal-voice`), ร่างเอกสาร (`technical-writing`) และตรวจเอกสารบันทึก (`document-review`) เสียง แปลว่า voice

## เหมาะกับใคร

- developer ที่ให้ AI ร่าง chat, standup, PR, commit, ข้อความใน UI, ADR หรือ README ทั้งไทยและอังกฤษ
- ทีมที่ได้ output ภาษาไทยจาก AI แล้วอ่านเหมือนงานแปล
- ใครที่เคยวาง draft แล้วคิดว่า "นี่มันเสียง AI"

## ติดตั้ง

```bash
claude plugin marketplace add wasikarn/siang
claude plugin install siang@siang
```

## Skill ที่มี

**`siang:thai-pua-repair`**

- ใช้เมื่อ: ข้อความที่ extract จาก PDF ไทยมีอักขระ private-use หรือวรรณยุกต์เพี้ยน
- ทำอะไร: แปลง glyph 27 ตัวของฟอนต์ UPC บน Windows (U+F700..U+F71A) กลับเป็นอักษรไทยมาตรฐาน รายงานตัวที่แปลงไม่ได้ และเมื่อสั่งจะแก้ ToUnicode map ในไฟล์ PDF เอง ให้ copy และค้นหาได้ถูก (`pua_pdf.py` ต้องมี pikepdf)

เรียกด้วย slash command (`/siang:thai-pua-repair`) หรือสั่งเป็นประโยคก็ได้ ตัวอย่าง prompt:
```
ใช้ siang:thai-pua-repair: extract report.pdf แล้วซ่อมข้อความไทย
```

## skill อีก 4 ตัว

- `humanize`: เอากลิ่น AI ออกจากงานเขียน dev/tech `skills/humanize/` เก็บลำดับขั้นใน `SKILL.md`, cue sheet สากล 33 แถว, pattern เฉพาะภาษาไทย,
  โครงสร้างประโยคไทย, ตัวอย่าง และ `scripts/scan.py` ที่ไล่หา tell ที่ pattern จับได้ (em dash, คำสาย AI, ประโยคปิดแบบ chat,
  การสะกดและรูปแบบวันที่ภาษาไทย) พร้อมเลขบรรทัดและเลข §
- `personal-voice`: สร้าง profile เสียงจากตัวอย่างของคุณเอง แล้วเขียน draft ตาม profile
- `technical-writing` และ `document-review`: ร่างเอกสารที่ผู้อ่านใช้งานได้ และตรวจเอกสารบันทึกเทียบกับมาตรฐานของมัน

ทั้ง 4 ตัวกลับมาเป็น skill ใน 0.1.33 ตามเกณฑ์ใน `evals/README.md` (with-skill mean เกิน 0.90 และไม่มีเคสไหนแพ้เกิน 0.05)
ก่อนหน้านี้เกณฑ์มีเงื่อนไข Δ เฉลี่ยเหนือ Claude เปล่า +0.05 ด้วย เงื่อนไขนั้นถูกตัดออกเมื่อ 2026-11-10 ส่วนผล Δ ที่บันทึกไว้คงอยู่เป็นประวัติ

## โครงสร้าง repo

| path | เนื้อหา |
|---|---|
| `skills/humanize/` | `SKILL.md` ลำดับขั้น, cue sheet, pattern สากลและไทย, โครงสร้างประโยคไทย, ตัวอย่าง, แหล่งอ้างอิง, `scripts/scan.py` |
| `skills/personal-voice/`, `skills/technical-writing/`, `skills/document-review/` | ตัวละ `SKILL.md` ไฟล์เดียว |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `evals/` | 43 เคสในรูปแบบของ `claude plugin eval` อธิบายใน `evals/README.md` |
| `tests/` | เช็กฟรีที่ CI รันทุก push: grader self-test, hook เช็ก version, ทุก § และ cue ต้องหาเจอ, `scan.py` จับ tell ที่ใส่ไว้ได้, `pua_fix.py` แปลง glyph ที่รู้จักได้ครบ, `pua_pdf.py` ซ่อม PDF จริงได้ตั้งแต่ต้นจนจบ |

## Eval

แต่ละเคสรันสองฝั่ง คือมี siang กับไม่มี siang ตัวเลขที่ควรดูคือส่วนต่าง (Δ) ไม่ใช่คะแนนรวม
เพราะ Claude เปล่า ๆ ก็ได้คะแนนสูงในหลายเคส

- 18 เคสของ `humanize` ทั้งไทยและอังกฤษ (ลบแล้วใน 0.1.28 บันทึกนี้เก็บไว้เป็นหลักฐาน) หลายเคสเป็น regression guard ที่ Claude เปล่า ๆ ก็ผ่าน
  หน้าที่ของมันคือจับตอนที่ siang แพ้ แต่ที่ดีขึ้นจริงมีไม่มาก Δ เฉลี่ย +0.04 ทั้ง 18 เคส ในทั้งสองชุดด้านล่าง
  ชุดละ 3 รอบต่อฝั่ง
  - Opus 5.5 (2026-11-09, siang 0.1.16, prompt ใน repo): ฝั่ง siang ผ่านครบทั้ง 54 รอบ แต่ Claude เปล่า ๆ
    ก็เกือบผ่านหมด ค่าใช้จ่ายต่อรอบของฝั่ง siang ราว 2.1 เท่าของฝั่งเปล่า ($0.216 เทียบกับ $0.102)
  - Sonnet 5.5 กับ prompt ที่สั่งให้เขียนใหม่ให้เหมือนคนเขียน ไม่บอก genre และไม่บอกขั้นตอน แต่ยังมีวงเล็บว่า "(use the
    `siang:humanize` skill if you have it)": siang ไม่ได้ผ่านทุกเคส ตก grader echo-back ตัวเก่าใน th-cs-echo-planted
    (0.67 เท่ากับฝั่งเปล่า ไม่ได้เปิดอ่าน output จริง) และตก grader `VM 3 ใบ` ใน th-grammar-planted (0.53
    เทียบกับฝั่งเปล่า 0.60) ส่วนที่ดีขึ้นกระจุกอยู่ที่วันที่และเวลาภาษาไทย น้ำเสียงของ standup ไทย การไม่แตะข้อความ
    chat ไทยที่ดีอยู่แล้ว และ tell ในภาษาอังกฤษที่ละเอียด ค่าใช้จ่ายต่อรอบของฝั่ง siang ราว 1.7 เท่า ($0.081 เทียบกับ $0.048)

  ผลของทั้งสองชุด (คะแนน ค่าใช้จ่าย และผลของ grader ทุกตัว) เก็บไว้ใน [`docs/eval-runs/`](docs/eval-runs/) prompt
  ของรอบ Sonnet อยู่ใน JSON นั้น แต่ prompt ใน repo ยังระบุชื่อ skill อยู่ รันซ้ำจึงได้ตัวเลขของ Sonnet ไม่ตรงเป๊ะ
  หลังแก้ตาม deep-audit (0.1.24) รันเคสภาษาไทยทั้ง 14 เคสใหม่เฉพาะฝั่ง siang ได้ 1.00 ครบ 42 รอบ
- เคส held-out ของ skill อีก 4 ตัว (เขียนโดย agent ที่ไม่เคยเห็นขั้นตอนของ skill) รัน 5 รอบต่อฝั่ง ตามกฎที่ตั้งไว้ก่อนรัน
  (ดู `evals/README.md`): `thai-pua-repair` Δ เฉลี่ย +0.095 (คะแนน 1.00) ผ่านเกณฑ์
- ผลตามเกณฑ์ปัจจุบัน (with-skill mean เกิน 0.90 และไม่มีเคสไหนแพ้เกิน 0.05) แต่ละตัววัดบนข้อความที่ระบุ:
  `personal-voice` 0.975 (ข้อความ 0.1.32, เคสแย่สุด −0.025), `humanize` 0.94 (`SKILL.md` ตัวสุดท้าย, ไม่มีเคสต่ำกว่า −0.03),
  `document-review` 0.985 (แย่สุด −0.03), `technical-writing` 0.985 (หลังแก้ grader, แย่สุด −0.03) คอลัมน์ Δ ใน `evals/README.md`
  เป็นบันทึกของกฎ +0.05 เดิม ทั้ง 4 ตัวไม่ผ่านกฎนั้น จึงถูกถอดใน 0.1.26 ถึง 0.1.32
- 1 เคส `trigger` เช็กว่า `thai-pua-repair` ถูกเรียกเองจากงานโดยไม่ระบุชื่อ: ถูกเรียกทุกรอบ

เช็กฟรีโดยไม่เรียก API: `bash tests/test-graders.sh` ส่วนรันจริง (เสียเงิน) คือ
`claude plugin eval . --scaffold --tag thai-pua-repair --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
(ถ้าไม่ได้รันใน
terminal แบบ interactive ให้เติม `--trust-plugin`)

## เครดิตและ license

siang เริ่มจาก skill `tech-humanize` ใน [wasikarn/method-harness](https://github.com/wasikarn/method-harness)
ความรู้ที่ใช้มาจากแหล่งเหล่านี้

- [blader/humanizer](https://github.com/blader/humanizer) (MIT, Copyright (c) 2025 Siqi Chen): ชื่อ ลำดับ และโครงของ
  pattern สากล §1-§30 (จาก v2.7.0) กับ §59-§61 และการ scan ซ้ำในขั้นที่ 6 (จาก v3.1.0)
- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing) ดูแลโดย
  WikiProject AI Cleanup: รายการ tell ต้นทางที่ทั้ง humanizer และ siang ใช้ตั้งต้น (license CC BY-SA 4.0 และ commit
  ก่อน `27feec4` ยังมีข้อความที่ยกมาจากหน้านี้ ดูใน notices)
- [chakrit/kien-thai](https://github.com/chakrit/kien-thai) (MIT, Copyright (c) 2026 Chakrit Wichian): กรอบการเล่าเรื่อง
  (discourse frame) ภาษาไทย AI tell ระดับภาษา และกฎสไตล์
- [Boom-Vitt/claude-thai-skills](https://github.com/Boom-Vitt/claude-thai-skills) (MIT, Copyright (c) 2026 Vittawat
  (Boom-Vitt)): สรรพนาม (§55) วันที่และเวลา (§56) การขอโทษและการรับปาก (§57) อักขระที่มองไม่เห็น (§58) และระดับภาษา
  สำหรับตอบลูกค้า

ถ้อยคำของกฎและตัวอย่างเป็นของ siang เองตั้งแต่ 2026-11-09 ก่อนหน้านั้นคัดลอกข้อความจาก humanizer มาหลายส่วน
วันที่ 2026-11-09 ตรวจด้วย script ชั่วคราวเทียบกับทั้งสี่แหล่งนี้แล้ว ไม่เจอช่วงที่ซ้ำกันตั้งแต่หกคำขึ้นไป ยกเว้นชื่อ pattern
ชื่อหัวข้อ วลี tell และรายการคำที่กฎยกมา และชื่อแหล่ง ส่วน script ตัวนั้นไม่ได้อยู่ใน repo

ไฟล์ไหนดัดแปลงอะไรมา และ license ฉบับเต็ม ดูได้ที่ [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)
ขอบคุณผู้เขียนทั้งสามที่เผยแพร่งานภายใต้ MIT

license ของ repo นี้คือ MIT ดู [LICENSE](LICENSE)
