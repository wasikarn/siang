# siang (เสียง)

**skill สำหรับ Claude Code: เขียนด้วยเสียงของคุณเอง ซ่อมข้อความจาก PDF ไทย และชุดอ้างอิงสำหรับเอากลิ่น AI ออกจากงานเขียน**

[English](README.en.md)

> ข้อความจาก AI มีกลิ่น

standup ที่เปิดว่า "ยินดีที่จะแจ้งให้ทราบ" คำอธิบาย PR ที่มีสามข้อยาวเท่ากันเป๊ะ ประกาศภาษาไทยที่ลงท้ายครับ
ทุกประโยค แถมใช้ "ซึ่ง" กับ "โดย" เต็มไปหมด คนอ่านรู้ตั้งแต่บรรทัดแรก แล้วก็เลิกเชื่อส่วนที่เหลือ

siang เป็น plugin ของ Claude Code สองงาน คือเขียนด้วยเสียงของคุณเอง และซ่อมข้อความที่ดึงจาก PDF ไทยแล้วเพี้ยน
ส่วนการเอากลิ่นนี้ออกทั้งภาษาอังกฤษ ภาษาไทย และไทยปนอังกฤษ เป็นชุดอ้างอิงใน `docs/humanize/` ไม่ใช่ skill (เหตุผลอยู่ท้ายหัวข้อถัดไป)
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

## Skill 2 ตัว

**`siang:thai-pua-repair`**

- ใช้เมื่อ: ข้อความที่ extract จาก PDF ไทยมีอักขระ private-use หรือวรรณยุกต์เพี้ยน
- ทำอะไร: แปลง glyph 27 ตัวของฟอนต์ UPC บน Windows (U+F700..U+F71A) กลับเป็นอักษรไทยมาตรฐาน รายงานตัวที่แปลงไม่ได้ และเมื่อสั่งจะแก้ ToUnicode map ในไฟล์ PDF เอง ให้ copy และค้นหาได้ถูก (`pua_pdf.py` ต้องมี pikepdf)

**`siang:personal-voice`**

- ใช้เมื่อ: อยากได้ draft ด้วยเสียงของตัวเอง
- ทำอะไร: วัดจากตัวอย่างของคุณ เก็บเฉพาะลักษณะที่เจอในตัวอย่างอย่างน้อยสองชิ้น เขียนจากข้อเท็จจริงของคุณ แล้วเทียบ draft กับ profile


เรียกด้วย slash command (`/siang:personal-voice`) หรือสั่งเป็นประโยคก็ได้ ตัวอย่าง prompt:
```
ใช้ siang:personal-voice: samples/ คือข้อความของฉัน เขียน draft.md ใหม่ให้เหมือนฉัน
```

## ชุดอ้างอิง humanize (ไม่ใช่ skill)

`docs/humanize/` เก็บสิ่งที่เคยเป็น skill `humanize`: ลำดับขั้นใน `README.md`, cue sheet สากล 33 แถว, pattern เฉพาะภาษาไทย,
โครงสร้างประโยคไทย และ `scripts/scan.py` ที่ไล่หา tell ที่ pattern จับได้ (em dash, คำสาย AI, ประโยคปิดแบบ chat,
การสะกดและรูปแบบวันที่ภาษาไทย) พร้อมเลขบรรทัดและเลข § ใช้อ่านเองหรือสั่งให้ Claude อ่านก็ได้
`python3 docs/humanize/scripts/scan.py <ไฟล์>` (รันจาก clone ของ repo; ตัวที่ติดตั้งเก็บ kit ไว้ที่ `~/.claude/plugins/cache/siang/siang/<version>/docs/humanize/`)

มันถูกถอดจากการเป็น skill ใน 0.1.28 เพราะบนเคส held-out สี่เคสที่ agent ซึ่งไม่เคยเห็น skill เขียน (5 รอบต่อฝั่ง)
Δ เฉลี่ยเป็น 0.00 ต่ำกว่าเกณฑ์ +0.05 ตัวเลขทั้งหมดอยู่ใน `evals/README.md`

## โครงสร้าง repo

| path | เนื้อหา |
|---|---|
| `docs/humanize/` | ชุดอ้างอิงเอากลิ่น AI ออก (ไม่ใช่ skill): `README.md` ลำดับขั้น, cue sheet, pattern สากลและไทย, โครงสร้างประโยคไทย, ตัวอย่าง, แหล่งอ้างอิง, `scripts/scan.py` |
| `skills/personal-voice/` | `SKILL.md` |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `evals/` | 13 เคสในรูปแบบของ `claude plugin eval` อธิบายใน `evals/README.md` |
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
  (ดู `evals/README.md`): `thai-pua-repair` Δ เฉลี่ย +0.095 (คะแนน 1.00) และ `personal-voice` Δ +0.075 (0.985) ผ่านเกณฑ์ (วัดบน 0.1.27 หลังจากนั้น step 5 ถูกเขียนใหม่ ดู `evals/README.md`)
  โดย `personal-voice` รันใหม่บนสองเคสที่ agent ซึ่งไม่เคยเห็น skill เขียนขึ้นใหม่ (เคสเดิมเคยถูกใช้ปรับ skill ใน 0.1.21)
  ผลของมันมาจากเคสเดียว อีกเคสได้ 1.00 เท่ากับ Claude เปล่า
- `humanize` ไม่ผ่านเกณฑ์บนเคส held-out สี่เคสที่เขียนใหม่แบบ blind: with-skill 0.94 แต่ Δ เฉลี่ย 0.00 (0.00, −0.03, +0.03, 0.00)
  จึงถูกถอดจากการเป็น skill ใน 0.1.28 และเก็บเป็น `docs/humanize/`
- `document-review` ไม่ผ่านเกณฑ์ (Δ เฉลี่ย −0.02 บนเคส held-out สองเคส Claude เปล่า ๆ เจอข้อผิดชุดเดียวกัน)
  จึงถูกลบออกจาก skill ใน 0.1.26 และเก็บ checklist ไว้เป็นเอกสารที่ `docs/document-review-checklist.md`
- `technical-writing` ตกเกณฑ์หลังแก้ grader ที่ปฏิเสธคำตอบถูก 3 ตัวแล้วรันใหม่ (Δ เฉลี่ย +0.035 ต่ำกว่า +0.05)
  จึงถูกลบออกจาก skill ใน 0.1.27 และเก็บแนวทางไว้เป็นเอกสารที่ `docs/technical-writing-guide.md`
- 2 เคส `trigger` เช็กว่า skill ถูกเรียกเองจากงานโดยไม่ระบุชื่อ: ถูกเรียกทุกรอบ (เคสของ `humanize`, `document-review` และ `technical-writing` ถูกลบพร้อมตัว skill)

เช็กฟรีโดยไม่เรียก API: `bash tests/test-graders.sh` ส่วนรันจริง (เสียเงิน) คือ
`claude plugin eval . --scaffold --tag personal-voice --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
(เปลี่ยน tag เป็น `thai-pua-repair` และถ้าไม่ได้รันใน
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
