# Thai structural patterns (§43–§52): discourse frames

Adapted from chakrit/kien-thai (MIT, Copyright (c) 2026 Chakrit Wichian): `skills/kien-thai/SKILL.md` (Frames 1–7), `references/ai-tells.md`, `references/style-rules.md`, `references/grammar.md`. Rules paraphrased; all examples written fresh for dev/tech text.

**Load when:** the draft is Thai and longer than one sentence (`SKILL.md` step 3). The full frames fit genre D (blog, ADR, README, strategy, explainer) and genre B when a PR description runs to real paragraphs. In genre A (chat), C (UI strings, replies, errors) and short B (a standup, a one-line commit), which kien-thai itself excludes, apply only the sentence-order rule (§44: condition and time before the main clause) and leave the register frames alone. kien-thai register mapping: Explainer, News/reference and Personal blog all land in D; Marketing and Official/minutes are out of scope here.

`patterns-thai.md` §31–§42 catch words. These sections catch sentence shape: Thai written with English clause order, which reads as translated even when every word is fine. Many lexical tells (§33, §37) disappear once the shape is right, so run these first on D prose.

**Relation to §35.** §35 is message-level: a standup opens on the topic, not three clauses of background. §43 and §44 work inside one sentence: §43 fronts the topic, §44 fronts the condition or time. They do not contradict; a condition-first sentence can still sit first in a topic-first message.

---

### 43. Topic first, then comment

**Rule:** front what the sentence is about, then say something about it. English SVO with a heavy subject calques into `การที่...นั้น...` or a subject nobody would put first.

**Why AI breaks it:** it keeps the English subject slot. A patient that is really the topic stays buried behind the verb.

❌ `ทีมได้ตัดสินใจย้าย session store ไปใช้ Redis หลังจากเจอปัญหา lock`
✅ `session store เราตัดสินใจย้ายไป Redis หลังเจอปัญหา lock`

❌ `การที่ migration รันนานทำให้ deploy ช้า`
✅ `migration รันนาน deploy เลยช้าตาม`

Heuristic: when the subject is long, abstract, or is in fact what the verb acts on → move it up as the topic.

### 44. Lead with the condition, time and scope

**Rule:** put the condition, time or scope before the main clause. English hangs it at the end (`X when Y`, `X if Y`).

**Why AI breaks it:** it translates in source order and lands on a trailing `เมื่อ...`.

❌ `cache จะ miss เยอะเมื่อ deploy ใหม่`
✅ `พอ deploy ใหม่ cache ก็ miss เยอะ`

❌ `ให้ rollback ทันทีถ้า error rate เกิน 2%`
✅ `ถ้า error rate เกิน 2% ให้ rollback ทันที`

In dev prose prefer `พอ`, `ตอน`, `ถ้า`, `หาก` as the opener. `เมื่อ` reads stiff outside formal docs (kien-thai's `grammar.md` says the same, though its Frame 2 lists `เมื่อ`).

### 45. Space and paragraph carry the sentence break, not the period

**Rule:** inside a paragraph, a space ends a sentence. A period is for the paragraph's last line, a deliberate snap, or between two long sentences that space alone would blur.

**Why AI breaks it:** English puts a period after every sentence and the habit carries over, so Thai reads like a typewriter.

❌ `เพิ่ม index แล้ว. query เร็วขึ้น. CPU ลดลง.`
✅ `เพิ่ม index แล้ว query เร็วขึ้น CPU ก็ลดลง`

Test: two or more mid-paragraph periods between short clauses (under ~10 words) → collapse to spaces. This also feeds the `—` rule: the fix for a dash aside is a space or parens, never a period stack.

### 46. Close the clause with a final particle

**Rule:** Thai wraps a clause with a small particle: `ด้วย` (also), `แล้ว` (done, by now), `ไป`, `อยู่` (ongoing), `เลย`, `อยู่ดี` (still), `ต่างหาก` (it's Y, not X), `ก็แล้วกัน` (let's settle on it). Without one the sentence trails off.

**Why AI breaks it:** English has no matching token, so nothing gets translated into that slot.

Additive frames (`ไม่ได้...อย่างเดียว`, `ไม่ใช่แค่...`) almost always need `ด้วย`:
❌ `PR นี้ไม่ได้แก้ bug อย่างเดียว เพิ่ม test ให้ retry logic`
✅ `PR นี้ไม่ได้แก้ bug อย่างเดียว เพิ่ม test ให้ retry logic ด้วย`

This applies when both halves are real facts the reader needs. When the first half is empty (nobody thought the PR only did X), the contrast itself is the tell: handle it per §9.

Correction frames (`ไม่ได้อยู่ที่ X อยู่ที่ Y`) take `ต่างหาก`:
❌ `ต้นเหตุไม่ได้อยู่ที่ DB อยู่ที่ connection pool`
✅ `ต้นเหตุไม่ได้อยู่ที่ DB อยู่ที่ connection pool ต่างหาก`

A result clause followed by a "no need to X" clause needs a bridge (`โดย` or `ด้วย`); that one `โดย` fits the §33 budget:
❌ `cache ช่วยให้หน้าโหลดเร็วขึ้น ไม่ต้อง query DB ทุกครั้ง`
✅ `cache ช่วยให้หน้าโหลดเร็วขึ้น โดยไม่ต้อง query DB ทุกครั้ง`

These particles are not budgeted by §33; if one reads odd, rebuild the sentence instead of deleting it. `เป็นความ + verb` (`เป็นความตั้งใจ`) is required grammar, not §37 padding.

### 47. Drop the known subject; refer back with demonstratives

**Rule:** once the topic is set, drop the subject until control changes. Refer back with a demonstrative (`ตัวนี้`, `เคสนั้น`, `ตรงนี้`) instead of `มัน`, `เขา`, `พวกเขา`.

**Why AI breaks it:** English needs *it / they / we* in every clause, so AI repeats the pronoun or reaches for `มัน`.

❌ `เราย้าย cron ไปรันบน queue แล้ว เราเห็นว่าเราไม่ต้องเฝ้า server ตอนตีสองอีก`
✅ `ย้าย cron ไปรันบน queue แล้ว ไม่ต้องเฝ้า server ตอนตีสองอีก`

❌ `worker ค้างทุกคืน มันเกิดจาก memory leak`
✅ `worker ค้างทุกคืน ตัวการคือ memory leak`

**Limit:** if a clause opens with `เพราะ`, `ส่วน`, `ดังนั้น` and the referent is no longer clear, restore it with a demonstrative bridge (`เพราะแบบนี้...`, `ตรงนี้แหละที่...`), not with `มัน`. Use `ตรงนี้แหละที่` once per piece at most: repeated, it reads as a calque of the English cleft "this is where...".

### 48. Pace with ก็

**Rule:** `ก็` signals that the next part follows as expected, a soft concession, or "naturally". Typical shapes: `ก็เลย`, `X แล้วก็ Y`, `ถ้า X ก็ Y`, `พอ X ก็ Y`. Bare `แล้ว` also links sequenced actions.

**Why AI breaks it:** no English word does this job, so a model leaves `ก็` out and the Thai reads clipped.

❌ `พอเปิด debug log disk เต็ม`
✅ `พอเปิด debug log disk ก็เต็ม`

❌ `push tag CI build image ให้อัตโนมัติ`
✅ `push tag แล้ว CI จะ build image ให้เอง`

Use it for breath, not as a connector to sprinkle. One limit from kien-thai: it is wrong when the second clause is the first by definition (total cost is the sum of line items; no `ก็`).

### 49. Pivot with a question, a demonstrative, or plain แต่

**Rule:** move between ideas with a rhetorical question (`แล้วถ้า... ล่ะ`), a demonstrative bridge (`ตรงนี้แหละที่...`, `นี่คือเหตุผลที่...`), or a plain `แต่`. The lexical swap list for `อย่างไรก็ตาม` and `นอกจากนี้` already lives in §33 and §38.

**Why AI breaks it:** it pivots with the English formal connector, or lists problems and jumps straight into the fix with no turn at all.

❌ `อย่างไรก็ตาม การ cache ในหน่วยความจำมีข้อจำกัดเมื่อมีหลาย instance`
✅ `แต่พอรันหลาย instance การ cache ในหน่วยความจำก็มีข้อจำกัด`

Problem list → fix, in an ADR:
❌ `build ช้า flaky test เยอะ dev รอ CI นาน เราจึงเสนอให้แยก pipeline`
✅ `build ช้า flaky test เยอะ dev รอ CI นาน นี่แหละเหตุผลที่เราเสนอให้แยก pipeline`

Heuristic: for every "however" in the English draft, ask whether `แต่` or a question does the job. Usually one in two can go.

---

## Supporting structural rules

### 50. Sentence rhythm and seams

Thai happily puts a six-word sentence beside a thirty-word one. When all sentences come out at one length, split a few. Past ~25 Thai words without a space break, find a seam; an English sentence often turns into two or three Thai ones. Works with §39.4's 3–30 word range.

### 51. Opener and closer shape

Open on a fact, a symptom, a number or a question; never a panorama (`ในยุคปัจจุบัน...`) or a consensus claim (`เป็นที่ทราบกันดีว่า...`). Close without a recap (`โดยสรุปแล้ว...`): end on the next step, a question back to the reader, a quiet handoff (`เท่านี้ก่อน`), or just stop.
❌ `ขั้นต่อไปเราจะวัด p99 หลังย้ายครบทุก region โดยสรุปแล้ว การย้ายไป Redis ช่วยเพิ่มประสิทธิภาพของระบบอย่างมาก`
✅ `ขั้นต่อไปคือวัด p99 หลังย้ายครบทุก region`

The next step has to be one the source already states (here, the p99 check in the draft's first sentence; the recap after it goes); never invent one to replace a recap. With no next step in the source, just stop.

### 52. Prose before bullets

Write 2–4 sentence paragraphs first; use bullets only for items of the same kind, or for four items and up. A two-item bullet list in an ADR or README section reads as an outline, not a writer.
