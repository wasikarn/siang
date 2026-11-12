# siang (เสียง)

plugin ของ Claude Code สำหรับงานเขียนภาษาไทยและอังกฤษ: ซ่อมข้อความที่ดึงจาก PDF ไทยแล้วเพี้ยน
เอากลิ่น AI ออกจากงานเขียน เขียนด้วยเสียงของคุณเอง และร่างเอกสาร

[English](README.en.md)

## ทำไมต้องมี

ข้อความจาก AI มีกลิ่น standup ที่เปิดว่า "ยินดีที่จะแจ้งให้ทราบ" คำอธิบาย PR ที่มีสามข้อยาวเท่ากันเป๊ะ
ประกาศภาษาไทยที่ลงท้ายครับทุกประโยค คนอ่านรู้ตั้งแต่บรรทัดแรก แล้วก็เลิกเชื่อส่วนที่เหลือ
อีกปัญหาคือ PDF ไทยที่ copy ออกมาแล้วได้อักขระประหลาด ค้นหาไม่ได้ ใช้กับ RAG ไม่ได้

siang รวม skill 4 ตัวที่แก้สองเรื่องนี้ ชื่อ "เสียง" แปลว่า voice

## ติดตั้ง

```bash
claude plugin marketplace add wasikarn/siang
claude plugin install siang@siang
```

ติดตั้งแล้ว restart Claude Code เรียก skill ด้วย slash command (`/siang:humanize`) หรือสั่งเป็นประโยคก็ได้
ถ้างานตรงกับ description Claude จะเลือก skill เอง

## Skill ที่มี

| skill | ใช้เมื่อ | ทำอะไร |
|---|---|---|
| `siang:thai-pua-repair` | ข้อความจาก PDF ไทยมีอักขระ private-use วรรณยุกต์หรือสระเพี้ยน | แปลงกลับเป็นอักษรไทยมาตรฐาน หรือซ่อมไฟล์ PDF เอง |
| `siang:humanize` | แก้ chat, standup, PR, commit, ข้อความใน UI, ADR, README ให้ไม่เหมือน AI เขียน | ไล่ tell ตาม pattern แล้วเขียนใหม่ ทั้งอังกฤษ ไทย และไทยปนอังกฤษ |
| `siang:personal-voice` | อยากให้งานเขียนฟังเหมือนคุณ | สร้าง profile เสียงจากตัวอย่างงานของคุณ แล้วร่างตาม profile |
| `siang:technical-writing` | ร่างหรือปรับ README, how-to, tutorial, reference, runbook, ADR, release note | เขียนให้ผู้อ่านทำงานจนเสร็จได้ ข้อมูลมาจาก code และผลคำสั่งจริง |

ตัวอย่าง prompt:

```
ใช้ siang:thai-pua-repair: extract report.pdf แล้วซ่อมข้อความไทย
ใช้ siang:humanize ปรับ draft PR description นี้
```

### thai-pua-repair

แปลง glyph 27 ตัวของฟอนต์ UPC บน Windows (U+F700..U+F71A) กลับเป็นอักษรไทยมาตรฐาน
รายงานตัวที่แปลงไม่ได้ (U+F71B..U+F71D และ private-use ชุดอื่น) ใช้ script ตรง ๆ ได้ด้วย:

```bash
# ข้อความ: เช็กอย่างเดียว (exit 1 ถ้าเจอ glyph ที่แปลงได้, exit 2 ถ้ามีตัวที่แปลงไม่ได้เหลือ)
python3 skills/thai-pua-repair/scripts/pua_fix.py --check extracted.txt

# ข้อความ: แปลงแล้วพิมพ์ออก stdout (อ่านจาก stdin ได้ถ้าไม่ระบุไฟล์)
python3 skills/thai-pua-repair/scripts/pua_fix.py extracted.txt > fixed.txt

# ไฟล์ PDF: แก้ ToUnicode map ให้ copy และค้นหาได้ถูก (ต้อง pip install pikepdf)
python3 skills/thai-pua-repair/scripts/pua_pdf.py in.pdf out.pdf
```

`pua_pdf.py` แก้เฉพาะ `/ToUnicode` ของแต่ละฟอนต์ หน้าตาของหน้า PDF ไม่เปลี่ยน

### ตรวจเอกสาร (ไม่ใช่ skill แล้ว)

`document-review` ถูกลดเป็นเอกสารธรรมดาใน 0.1.38 เพราะใน eval แบบ blind ได้คะแนนเท่า Claude เปล่า ๆ
ขั้นตอนอยู่ใน [`docs/document-review/README.md`](docs/document-review/README.md) ส่วน `docs/document-review/doc_check.py` หาจุดที่เช็กด้วยเครื่องได้ใน Markdown: cross-reference ที่หาไม่เจอ, เลข
หัวข้อและรายการที่ข้ามหรือซ้ำ, ปริมาณที่ขัดกัน (30 minutes กับ 30 s), ตัวย่อที่ไม่เคยอธิบาย, วันที่ที่เป็นไปไม่ได้
และ section ที่ขาดหรือผิดลำดับ ผลเป็น candidate ให้คนตัดสินต่อ:

```bash
python3 docs/document-review/doc_check.py runbook.md --sections "Purpose,Procedure,Rollback"
```

### humanize

`skills/humanize/` เก็บลำดับขั้นใน `SKILL.md`, cue sheet, pattern สากล (§1-§30, §59-§61), pattern ไทย
(§31-§42, §53-§58), โครงสร้างประโยคไทย (§43-§52) และตัวอย่าง `scripts/scan.py` ไล่หา tell ที่ pattern
จับได้ (em dash, คำสาย AI, ประโยคปิดแบบ chat, การสะกดและรูปแบบวันที่ไทย) พร้อมเลขบรรทัดและเลข §:

```bash
python3 skills/humanize/scripts/scan.py draft.md   # หรือ pipe เข้า stdin
```

ผลที่ได้เป็น candidate ไม่ใช่คำตัดสิน อ่านทุก hit ก่อนแก้

## โครงสร้าง repo

| path | เนื้อหา |
|---|---|
| `skills/humanize/` | `SKILL.md`, cue sheet, pattern สากลและไทย, ตัวอย่าง, แหล่งอ้างอิง, `scripts/scan.py` |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `skills/personal-voice/` | `SKILL.md`, `scripts/voice_stats.py` |
| `skills/technical-writing/` | `SKILL.md` ไฟล์เดียว |
| `evals/` | 64 เคสรูปแบบ `claude plugin eval` อธิบายใน [`evals/README.md`](evals/README.md) |
| `docs/document-review/` | ขั้นตอนตรวจเอกสาร (เดิมเป็น skill) และ `doc_check.py` |
| `docs/eval-runs/` | ผลรัน eval ที่เก็บไว้ ([README](docs/eval-runs/README.md)) |
| `tests/` | เช็กฟรีที่ CI รันทุก push |
| `GLOSSARY.md` | ศัพท์ของโปรเจกต์ |

## Eval

skill ตัวหนึ่งอยู่ใน plugin ได้เมื่อผ่านเกณฑ์: with-skill mean เกิน 0.90 (5 รอบต่อฝั่ง) และไม่มีเคสไหนแพ้ Claude
เปล่า ๆ เกิน 0.05 บนเคส held-out ที่เขียนโดย agent ที่ไม่เคยเห็น skill และ grader ถูกแช่แข็งก่อนรัน
ตัวเลขที่ควรดูคือส่วนต่างต่อเคส ไม่ใช่คะแนนรวม เพราะ Claude เปล่า ๆ ได้คะแนนสูงในหลายเคส

รอบ blind ล่าสุดของแต่ละ skill (รายละเอียดใน `evals/README.md`):

| skill | รอบ (เวอร์ชัน) | with-skill mean | Δ เฉลี่ย | Δ เคสแย่สุด |
|---|---|---|---|---|
| `personal-voice` | คู่เคส blind `holdout6` (0.1.39) | 0.987 | +0.04 | 0.00 |
| `humanize` | รอบที่ห้า (0.1.36) | 0.98 | +0.15 | 0.00 |
| `technical-writing` | รอบที่ห้า (0.1.36) | 0.956 | +0.144 | +0.11 |

รันเดียวกันบน 0.1.36 ยังรันเคส `technical-writing` เก่าอีกเคสนอกรอบ และเคสนั้นแพ้ −0.025
ผลรันซ้ำเคสคู่เดิมของ `personal-voice` บน 0.1.39 (0.992, +0.033) ไม่นับเป็น blind เพราะการแก้ข้อหนึ่งของ 0.1.39
(จับ ปล. เป็น P.S.) เพิ่มเข้ามาหลังจาก reviewer ชี้บรรทัดในเคสคู่นั้น

`thai-pua-repair` ผ่านด้วย Δ เฉลี่ย +0.095 (คะแนน 1.00) วิธีวัด ประวัติเกณฑ์ และต้นทุนต่อรอบอยู่ใน
`evals/README.md` กับ `docs/eval-runs/`

## พัฒนา

ก่อน commit:

```bash
claude plugin validate .
bash tests/test-graders.sh        # grader self-test (ฟรี ไม่เรียก API)
bash tests/test-section-refs.sh   # ทุก §N และ cue #N ต้องหาเจอ
bash tests/test-scan.sh
bash tests/test-voice.sh
bash tests/test-doc-check.sh
bash tests/test-pua.sh
bash tests/test-pua-pdf.sh        # ข้ามถ้าไม่มี pikepdf และ pdftotext
bash tests/test-version-hook.sh
```

- แก้อะไรใน `skills/` ต้องเพิ่ม `version` ใน `.claude-plugin/plugin.json` ไม่งั้น `claude plugin update`
  ไม่คัดลอกอะไร เปิด hook ครั้งเดียวต่อ clone: `git config core.hooksPath git-hooks`
- เลข section ใหม่ใช้เลขถัดจากตัวสุดท้ายที่มี (ดู `CLAUDE.md`) ห้าม renumber
- รัน eval จริง (เสียเงิน):
  `claude plugin eval . --scaffold --tag thai-pua-repair --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
  (ถ้าไม่ได้รันใน terminal แบบ interactive ให้เติม `--trust-plugin`)

กฎเต็มอยู่ใน [`CLAUDE.md`](CLAUDE.md)

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
