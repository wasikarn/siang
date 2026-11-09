# siang (เสียง)

**skill สำหรับ Claude Code ที่ช่วยให้งานเขียนสาย dev อ่านแล้วเหมือนคนเขียนจริง**

[English](README.en.md)

> ข้อความจาก AI มีกลิ่น

standup ที่เปิดว่า "ยินดีที่จะแจ้งให้ทราบ" คำอธิบาย PR ที่มีสามข้อยาวเท่ากันเป๊ะ ประกาศภาษาไทยที่ลงท้ายครับ
ทุกประโยค แถมใช้ "ซึ่ง" กับ "โดย" เต็มไปหมด คนอ่านรู้ตั้งแต่บรรทัดแรก แล้วก็เลิกเชื่อส่วนที่เหลือ

siang เป็น plugin ของ Claude Code ที่เอากลิ่นนี้ออกทั้งภาษาอังกฤษ ภาษาไทย และไทยปนอังกฤษ
และยังช่วยอีกสามงานที่ใกล้กัน คือเขียนเอกสารให้คนอ่านทำตามได้ เขียนด้วยเสียงของคุณเอง และซ่อมข้อความที่ดึงจาก PDF ไทยแล้วเพี้ยน
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

## สี่ skill

| Skill | ใช้เมื่อ | ทำอะไร |
|---|---|---|
| `siang:humanize` | draft อ่านแล้วเหมือน AI เขียน | ไล่หา AI tell ทุกจุดจาก cue sheet แล้วเขียนใหม่ จากนั้นอ่านซ้ำหาส่วนที่ยังเหลือ |
| `siang:technical-writing` | ต้องการ how-to, tutorial, หน้า reference, runbook หรือ README | เลือก Diátaxis หนึ่งแบบต่อเอกสาร เอาข้อเท็จจริงจากโค้ดและคำสั่งที่รันเอง ส่วนที่ยังไม่ได้ตรวจใส่ `TODO: verify` |
| `siang:thai-pua-repair` | ข้อความที่ extract จาก PDF ไทยมีอักขระ private-use หรือวรรณยุกต์เพี้ยน | แปลง glyph 27 ตัวของฟอนต์ UPC บน Windows (U+F700..U+F71A) กลับเป็นอักษรไทยมาตรฐาน รายงานตัวที่แปลงไม่ได้ และเมื่อสั่งจะแก้ ToUnicode map ในไฟล์ PDF เอง ให้ copy และค้นหาได้ถูก (`pua_pdf.py` ต้องมี pikepdf) |
| `siang:personal-voice` | อยากได้ draft ด้วยเสียงของตัวเอง | วัดจากตัวอย่างของคุณ เก็บเฉพาะลักษณะที่เจอในตัวอย่างอย่างน้อยสองชิ้น เขียนจากข้อเท็จจริงของคุณ แล้วเทียบ draft กับ profile |

เรียกด้วย slash command (`/siang:humanize`) หรือสั่งเป็นประโยคก็ได้ ตัวอย่าง prompt:

```
humanize standup update นี้ genre B เก็บตัวเลขทุกตัว
```

```
ใช้ siang:technical-writing เขียน docs/deploy.md ใหม่ให้ on-call engineer
```

```
ใช้ siang:personal-voice: samples/ คือข้อความของฉัน เขียน draft.md ใหม่ให้เหมือนฉัน
```

## `humanize` ทำงานยังไง

วนตามลำดับนี้

1. เลือก genre (A chat, B standup/PR/commit, C ข้อความ UI/error, D บทความ/blog/ADR) และภาษา
2. วางแผน grit คือรายละเอียดเฉพาะจากต้นฉบับที่ฉบับเขียนใหม่ต้องเก็บไว้
3. ไล่หา AI tell ทุกจุดจาก cue sheet สากล 33 แถว บวก pattern เฉพาะภาษาไทยถ้ามีข้อความไทย
   `scripts/scan.py` รันก่อนและแสดง tell ที่ pattern จับได้ (em dash, คำสาย AI, ประโยคปิดแบบ chat,
   การสะกดและรูปแบบวันที่ภาษาไทย) พร้อมเลขบรรทัดและเลข § แล้วโมเดลตัดสินทีละจุดและอ่านหาที่เหลือ
4. เขียน draft ถามตัวเองว่า "ตรงไหนยังเหมือน AI" แล้วเขียนฉบับสุดท้าย

มีกฎสองข้อที่ใช้ตลอด คือไม่แต่งข้อเท็จจริงเพิ่ม (claim ที่ตรวจไม่ได้ตัดทิ้งหรือลดน้ำหนัก ไม่เดาให้) และถ้าเป็นไฟล์
จะแก้เฉพาะร้อยแก้ว code block, คำสั่ง, frontmatter และข้อความอ้างอิงต้องเหมือนเดิมทุก byte

## โครงสร้าง repo

| path | เนื้อหา |
|---|---|
| `skills/humanize/` | `SKILL.md`, cue sheet, pattern สากลและไทย, โครงสร้างประโยคไทย, ตัวอย่าง, แหล่งอ้างอิง, `scripts/scan.py` |
| `skills/technical-writing/` | `SKILL.md` |
| `skills/personal-voice/` | `SKILL.md` |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `evals/` | 36 เคสในรูปแบบของ `claude plugin eval` อธิบายใน `evals/README.md` |
| `tests/` | เช็กฟรีที่ CI รันทุก push: grader self-test, hook เช็ก version, ทุก § และ cue ต้องหาเจอ, `scan.py` จับ tell ที่ใส่ไว้ได้, `pua_fix.py` แปลง glyph ที่รู้จักได้ครบ, `pua_pdf.py` ซ่อม PDF จริงได้ตั้งแต่ต้นจนจบ |

## Eval

แต่ละเคสรันสองฝั่ง คือมี siang กับไม่มี siang ตัวเลขที่ควรดูคือส่วนต่าง (Δ) ไม่ใช่คะแนนรวม
เพราะ Claude เปล่า ๆ ก็ได้คะแนนสูงในหลายเคส

- 18 เคสของ `humanize` ทั้งไทยและอังกฤษ หลายเคสเป็น regression guard ที่ Claude เปล่า ๆ ก็ผ่าน
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
- เคส held-out ของอีกสาม skill (เขียนโดย agent ที่ไม่เคยเห็นขั้นตอนของ skill) รันครั้งสุดท้ายหลังล็อก grader
  5 รอบต่อฝั่ง ตามกฎที่ตั้งไว้ก่อนรัน (ดู `evals/README.md`): `personal-voice` Δ เฉลี่ย +0.08 (คะแนน 0.95),
  `technical-writing` Δ +0.08 (0.98) และ `thai-pua-repair` Δ +0.12 (1.00) ผ่านเกณฑ์ แต่ Δ ของสอง skill แรกเฉียดเกณฑ์ +0.05
  และมีความคลาดเคลื่อนระดับเดียวกัน
- `document-review` ไม่ผ่านเกณฑ์ (Δ เฉลี่ย −0.02 บนเคส held-out สองเคส Claude เปล่า ๆ เจอข้อผิดชุดเดียวกัน)
  จึงถูกลบออกจาก skill ใน 0.1.26 และเก็บ checklist ไว้เป็นเอกสารที่ `docs/document-review-checklist.md`
- 4 เคส `trigger` เช็กว่า skill ถูกเรียกเองจากงานโดยไม่ระบุชื่อ: ถูกเรียกทุกรอบ (เคสที่ห้าของ `document-review` ถูกลบพร้อมตัว skill)

เช็กฟรีโดยไม่เรียก API: `bash tests/test-graders.sh` ส่วนรันจริง (เสียเงิน) คือ
`claude plugin eval . --scaffold --tag humanize --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
(เปลี่ยน tag เป็น `technical-writing`, `personal-voice` หรือ `thai-pua-repair` และถ้าไม่ได้รันใน
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
