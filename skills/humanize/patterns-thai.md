# Thai-Specific Patterns (extends `patterns-universal.md` §1-§30)

## Contents

- 31. Thai terminology drift and calque
- 32. Anti-fabrication discipline (32.1-32.10)
- 33. Connective density
- 34. Lexical budget
- 35. Topic-first vs background-first
- 36. Marketing calques (36.1)
- 37. Nominalization avoidance
- 38. Code-switching tells
- 39. Register-specific tells
- 40. AI-leaked Thai closers
- 41. Over-formal address (pointer to 32.8)
- 42. Quick reference
- 53. Surface grammar slips
- 54. Headings
- 55. Pronouns and self-reference
- 56. Dates, times and numbers
- 57. Apology and promises (human customer replies)
- 58. Hidden characters and marks
- 43-52: sentence and paragraph structure, in `patterns-thai-structure.md`

> This file extends the catalog in `patterns-universal.md` with Thai-only patterns (§31-§42, §53-§58; §43-§52 live in `patterns-thai-structure.md`) that only Thai text needs: terminology & calque, anti-fabrication, connectives, register matrix, code-switching tells, AI-leaked closers. Read `SKILL.md` §0 (register and language gate) first, then come back here.
>
> ❌/✅ below is the notation for bad/good examples (like code // BAD / // GOOD), not the decorative emoji that §18 in `cue-sheet.md` says to cut from real writing.

---

## THAI-SPECIFIC PATTERNS (extend catalog with §31-§42, §53-§58)

### 31. Thai Terminology Drift & Calque (TBD-disciplined decisions)

**Problem:** Three terminology mistakes show up repeatedly in AI Thai text:

(a) **Drift in meaning**: words whose meaning has drifted in Thai (e.g. `API` usually means only a web API, but in practice a lib/function interface is an API too) → **keep English for precision**
(b) **Calque (`แปลตรงตัว`)**: a Thai verb that translates the English word literally but does not match the real action
(c) **Non-standard transliteration**: ad-hoc Thai spelling of an English word that does not follow the Royal Society's English-to-Thai transliteration rules (`หลักเกณฑ์การทับศัพท์ภาษาอังกฤษ`). Not RTGS: RTGS is the reverse system, Thai written in Latin letters.

**Meaning-overlap test (run BEFORE the decision flow below, on every candidate term — not just terms already in the glossary table):** for any Thai noun/verb standing in for an English technical term, ask *does this word's actual, common meaning overlap with the technical meaning, or does it just sound like a plausible translation?* A grammatically-fine sentence is not evidence the term is correct — `ตั๋ว` (travel/event ticket) reads as a fine translation of "ticket" and is still (a) drift-in-meaning, because its real meaning has nothing to do with an issue-tracker record. Fail this test on any term, glossary or not → treat as (a). This is the check that catches new drift the glossary table hasn't enumerated yet; the table only covers terms already caught once.

**3 ways to decide terminology:**

| Method | Example | Use when |
|--------|---------|----------|
| **เก็บอังกฤษ** (Latin) | `staging`, `merge`, `API`, `PR #82` | internal dev; คำที่แปลแล้วเพี้ยน/กำกวม |
| **ทับศัพท์** (อักษรไทย) | ซอฟต์แวร์, ดิจิทัล, เวอร์ชัน | คำที่ฝังในภาษาไทยทั่วไปแล้ว |
| **แปล** (ความหมายไทย) | ฐานข้อมูล, การควบคุมเวอร์ชัน | user-facing; non-dev อ่าน |

**Decision flow:**
```
Customer/non-dev reads it? ─ yes ─> is there a clear Thai word? ─ yes ─> แปล (translate)
   │                                        └ none / translation drifts ─> เก็บอังกฤษ (keep English) + parenthetical gloss
   └ no (dev reads it) ─> เก็บอังกฤษ (default), or ทับศัพท์ (transliterate) if already embedded in Thai
```

**Verify transliteration** at https://transliteration.orst.go.th/search (Royal Society of Thailand). Never transliterate ad hoc. When a dev term must appear in Thai script, use the official spelling (`แคช`, `เบราว์เซอร์`, `อัปโหลด`, `ฟังก์ชัน`, `โพรโทคอล`, `ไฟร์วอลล์`), not an improvised one (`อัพโหลด`, `ฟังชั่น`). The Royal Society also coins Thai words for many terms (`จุดบกพร่อง` for bug, `ลงบันทึกเข้า` for login, `กิ่ง` for branch); devs rarely write those, and UIs say what the product shows (`เข้าสู่ระบบ`), so prefer the word the reader actually meets.

**Audience sets the English share.** Older, government or mass-market readers get less English and established ทับศัพท์ (`แอป`, `อีเมล`, `เว็บไซต์`); a dev channel keeps the English. Text written for Thai readers is never English-only. (Adapted from Boom-Vitt/claude-thai-skills (MIT); term spellings checked against the Royal Society computer and IT term list.)

**Section heading / user-facing headings:** never mix in `(Declined)` as in `## การชำระเงินไม่สำเร็จ (Declined)`; move the English word into the body or translate it as "ถูกปฏิเสธ" instead.

**Default glossary (standard Thai+tech):**

| Term | Internal | User-facing |
|----|----------|-------------|
| staging / develop / production | คงอังกฤษ | "ระบบทดสอบ" / (none) / "ระบบจริง" + อธิบาย |
| merge | merge | รวมโค้ด |
| deploy | deploy | นำขึ้นใช้งาน |
| session | session (เก็บอังกฤษ) | เซสชัน (ทับศัพท์ตามราชบัณฑิตฯ ไม่มีไม้หันอากาศ) |
| error code | error code | ข้อความแจ้งข้อผิดพลาด |
| declined (bank/payment) | declined (เก็บไว้ใน log เท่านั้น) | ถูกปฏิเสธ |
| login / logout | login / logout | เข้าสู่ระบบ / ออกจากระบบ |
| backup | backup | สำรองข้อมูล |
| cache | cache | แคช (ถ้าต้องเขียนเป็นไทย) |
| bug | bug | ข้อผิดพลาด (user-facing), บั๊ก (dev chat) |
| client (software) | client | ไม่ใช่ "ลูกค้า"; ใช้ชื่อแอปหรือ "แอป" |
| ticket / issue (Jira, GitHub) | ticket (เก็บอังกฤษ) | "รายการแจ้งงาน" หรือคง ticket — ห้ามใช้ "ตั๋ว" (แปลว่าตั๋วเดินทาง/ตั๋วหนัง คนละความหมายกับ issue-tracker record เลย — drift-in-meaning (a), ไม่ใช่แค่ทับศัพท์ผิด) |

> Product-specific terms (ANPR, dwell, front-facing, PDPA, traffic-campaign) → keep them in a separate project glossary, not in this global skill.

When replacing a calque, pick a verb matching the real action — not a vague placeholder — as the before/after pairs below do.

**Before (terminology drift + calque):**
> ตัวกรองหันหน้าผมถือไว้ก่อน รอดันแก้เรื่องมอไซค์

**After (default `เก็บอังกฤษ`, Thai as glue):**
> front-facing filter ยังไม่ปล่อยขึ้น prod รอแก้ moto-drop ก่อน

**Before (non-standard transliteration):**
> เซสชั่นหมดอายุ

**After (Royal Society spelling):**
> เซสชันหมดอายุ

**Before (drift-in-meaning — dev-tracker noun, not the deploy-vocab example above):**
> แผนผังความสัมพันธ์ตั๋ว (Dependency Map)

**After (`เก็บอังกฤษ`, keep English):**
> แผนผังความสัมพันธ์ Ticket (Dependency Map)

Same (a) drift-in-meaning failure as the `front-facing`/`API` cases above, in the issue-tracking vocabulary domain instead of deploy. The glossary row covers `ตั๋ว`; the meaning-overlap test above catches the next term the glossary doesn't list.


**One form per term, gloss once** (Adapted from chakrit/kien-thai (MIT)):
- Pick one form per term per document (English, ทับศัพท์, or Thai) and never switch mid-document.
- A concept the author coins gets glossed once: Thai term + (English, short gloss). After that, the term alone.
- Define inline in parens, not in a footnote: `idempotency key (ค่าที่ใช้กันยิงซ้ำ)`.

❌ `ใช้ container ... พอ คอนเทนเนอร์ ล่ม ... restart ตู้คอนเทนเนอร์ใหม่`
✅ `ใช้ container ... พอ container ล่ม ... restart container ใหม่`

### 32. Anti-Fabrication Discipline (TBD > invented specifics)

**Problem:** AI text is overconfident. Thai text in particular pads with invented file paths, branch names, ticket IDs, version numbers, dates, and metrics to look concrete. **Internal docs that teach the wrong workflow = technical debt someone else fixes later**, especially onboarding docs, because a new hire has no mental model to check against and will trust and follow them.

**3 red flags:**

(a) **Candidate-path fabrication**: a file that "probably lives" under `src/...` but was never verified:
> ❌ `webhook middleware ใหม่: src/presentation/middleware/rate-limiter.ts`
> ✅ `webhook middleware ใหม่ (path จะ confirm ใน PR diff)`

(b) **Invented metrics / load numbers**: load, latency, threshold figures that were never run:
> ❌ `burst test 500 req/min โควต้า 100/min → 400 queued ใน 1s`
> ✅ `burst test staging ผ่าน ตัวเลข load จะใส่หลัง run จริง`

(c) **Fake SLA / dates / versions**: firmware versions, rollout dates, rollback times that look real:
> ❌ `rely on camera firmware v2.1+ (2026-06-20 rollout)`
> ✅ `camera firmware dependency รอ confirm จาก camera team`
> ❌ `rollback ใช้เวลา 2-5 นาที`
> ✅ `rollback ใช้เวลาเท่าไหร่ขึ้นกับ image size/network/registry, verify หลัง deploy ครั้งแรก`

**TBD is a positive pattern, not an admission of failure:**
> ✅ `ไฟล์ที่แตะ รอ confirm จาก PR diff`
> ✅ `integration test [N] เคส drafted รอ run จริง`
> ✅ `Threshold/window size TBD จะใส่หลัง calibrate กับ traffic จริง`

`[N]` above is a placeholder for the real count from the source — never copy a number out of this example verbatim, and never let a future edit read this line as literal data instead of shape.

**PR description structure (TBD-disciplined):**
- `## สรุป` (1 paragraph)
- `## ทำอะไร` (bullet)
- `## โค้ด` (file paths from the diff only; otherwise TBD)
- `## ทดสอบแล้ว` (real results only)
- `## Risk`
- `## Related` (real ticket/branch)

### 32.1 Anti-Fabrication 3-Tier Tree (v2.2)

**Default = TIER 1 (DROP).** Use TIER 2 (HEDGE) only when the reader needs the signal but you still cannot verify. Use TIER 3 (CITE-VERIFIABLE) once it has actually been checked.

| Tier | Action | Use when | Example |
|------|--------|----------|---------|
| **T1 DROP** | ตัดทิ้งทันที, ไม่แม้แต่ hedge | fact ที่ตรวจไม่ได้, ผลกระทบสูง | ❌ `"Google 2024 Codex 55% เร็วขึ้น"` → ✅ ไม่พูดถึงเลย |
| **T2 HEDGE** | เขียน claim + marker เตือนผู้อ่าน verify | claim ที่ "เคยได้ยินมา" แต่ยังไม่ verify | `"อ้างกันว่า Codex 55% (ยังไม่ได้ verify)"` |
| **T3 CITE-VERIFIABLE** | claim + แหล่งที่ตรวจได้ (URL / paper / log) | fact ที่ตรวจแล้วจริง | `"Codex eval (<author> <year>, arxiv:<id>)"` |

**Hedge budget (hard rule):** real people write ≤1 hedge per clause. More than 1 hedge in one clause → drop to T1 instead.

❌ `"ผมคิดว่าน่าจะประมาณว่า 55% ครับ ถ้าจะให้แน่ใจก็ต้อง verify"` — 3 hedges ใน 1 clause = T1
✅ `"Codex eval 55% (<author> <year>, arxiv:<id>)"` — T3 หรือ ไม่พูดถึง

**Honest-broker preamble (cut to claim):** never open with `ผมไม่โทษเครื่องมือ แต่...` / `ต้องบอกว่า...` / `จริงๆ แล้ว...` before the claim. Go straight to the claim.

❌ `"ผมไม่โทษเครื่องมือนะ แต่ Codex เคย benchmark 55% ไว้"` — 50 tokens preamble
✅ `"Codex eval 55% (<author> <year>, arxiv:<id>)"` — 8 tokens

### 32.2 Red-Flag Patterns Catalog (v2.2)

Patterns that show AI is fabricating without knowing it; drop on sight:

1. **Path confidence without diff**: `"src/presentation/middleware/rate-limiter.ts"` with no grep of the file
2. **Round numbers without source**: `"55% faster"`, `"2-5 นาที"`, `"500 req/min"` that look too neat
3. **Date precision without calendar check**: `"2026-06-20 rollout"` with no calendar check
4. **Version pinning without release note**: `"v2.1+ (2026-Q2 release)"` with no changelog
5. **Authoritative source misattribution**: `"Google 2024 Codex eval"`, `"Stanford 2023 study"`, `"MIT 2024 report"` with no recallable URL
6. **Quote fabrication**: `"Steve Jobs เคยพูดว่า..."` with no source
7. **Library API hallucination**: `pandas.DataFrame.diff()` with a misremembered signature
8. **Self-consistent but wrong narratives**: a story that looks logical but every detail is wrong
9. **Acronym expansion invented**: `CRUD = Create, Read, Update, Delete` (correct, but AI loves to over-explain), `YAML = Yet Another Markup Language` (wrong; it is actually recursive)
10. **Generic company name + generic claim**: `"บริษัท Fortune 500 แห่งหนึ่งพบว่า..."`; no real name, does not count

**Fast verification (before writing):**
- URL → check with `WebFetch` or `WebSearch`
- Paper → arxiv/scholar search
- API → `context7` MCP or official docs
- File path → check with `Glob`/`Grep`
- Date → calendar
- Quote → original source (interview, paper, book)

### 32.3 Cite-as-Published Convention (v2.2)

When citing for real (T3), use a format the reader can verify onward:

| Type | Format | Example |
|------|--------|---------|
| Paper | `Author et al. (Year) [link/doi]` | `"<Author> et al. (<Year>) arxiv:<id>"` |
| Blog | `Title — Author, Date` | `"Postgres hypertables — Timescale, 2024-11"` |
| RFC/Standard | `RFC NNNN / ISO NNNN` | `"RFC 7231 (HTTP semantics)"` |
| Internal doc | `path:section` | `"docs/anpr/sse-stream.md#auth"` |
| Log/metric | `dashboard URL + timestamp` | `"grafana/tat-anpr?from=2026-06-04T15:11Z"` |

❌ `"จาก research 2024 พบว่า..."` — ไม่มี source ที่ verify ได้
✅ `"<Author> et al. (<Year>), arxiv:<id> — Codex 55% บน HumanEval"` (เฉพาะเมื่อเปิดอ่าน paper จริงแล้ว)

### 32.4 Thai Hedge Vocabulary (v2.2)

Thai hedges that work, ordered strong → weak:

| Strength | Thai | Use when |
|----------|------|----------|
| Strong | `"ผมไม่แน่ใจ"` | claim ที่ยังไม่ verify, แต่จำเป็นต้องพูดถึง |
| Strong | `"ยังไม่ได้ verify"` | claim ที่ "เคยได้ยิน" แต่ยังไม่ได้ตรวจ |
| Medium | `"น่าจะ"` | estimate ที่มี data รองรับบางส่วน |
| Medium | `"คาดว่า"` | projection ที่มี baseline |
| Medium | `"อ้างกันว่า"` | third-party claim ที่ยังไม่ verify |
| Weak | `"อาจจะ"` | possibility ทั่วไป |
| Weak | `"คงจะ"` | mild speculation |
| Avoid | `"ดูเหมือนว่า"` | ใช้บ่อยเกิน = AI tell |
| Avoid | `"น่าสนใจที่ว่า"` | ใช้บ่อยเกิน = AI tell |

**Thai writers normally use ≤1 hedge per clause.** ≥2 = AI.

**Native approximator** (Adapted from chakrit/kien-thai (MIT)): `แบบ` / `แบบว่า` in casual dev text (`แก้แบบเร็ว ๆ ไปก่อน`) is a weak hedge real people use and AI rarely does. Genre A/B, light D only. Avoid the stacked form `น่าจะ X อยู่ด้วยซ้ำ` (modal + progressive + emphatic): assert, or use one `อาจ`.

### 32.5 Citation Conventions — Thai Internal Doc (v2.2)

In an internal Thai doc use this pattern:

| Type | Format | Example |
|------|--------|---------|
| Jira | `TP-XXX` (verify ใน Jira ก่อน) | `"ดู TP-549"` |
| PR | `repo#PR_NUMBER` (verify ใน GitHub) | `"acme-api#64"` |
| Commit | short SHA + message | `"a1b2c3d — fix rate-limiter"` |
| Doc path | `path:line` | `"docs/anpr/measurement.md#L42"` |
| Slack/Chat | channel + date (link) | `"#anpr-dev 2026-06-02"` |

❌ `"ตามที่คุยกันในทีม"` — ไม่มี link, verify ไม่ได้
✅ `"Slack #anpr-dev 2026-06-02 — คุยกับ P'X เรื่อง rate-limiter threshold"`

### 32.6 Epistemic Frame — Self-Aware Uncertainty (v2.2)

Tell "ไม่รู้" (do not know) apart from "รู้แต่ไม่ได้ verify" (know, but unverified):

| Frame | Use when | Pattern |
|-------|----------|---------|
| **Unknown** | ไม่เคยเจอ case นี้ | `"ผมไม่เคยเจอเคสนี้"` |
| **Unverified** | เคยได้ยิน แต่ยังไม่ได้ verify | `"ผมเคยอ่านว่า... แต่ยังไม่ได้ verify"` |
| **Hedged estimate** | มี data บางส่วน | `"จาก data ที่เห็น น่าจะประมาณ X"` |
| **Verified** | ตรวจแล้ว | `"Wang et al. 2024 — 55%"` (พร้อม cite) |

❌ `"คิดว่าน่าจะประมาณ 55% ครับ ถ้า verify ก็คงจะใช่"` — 4 hedges, ไม่ระบุชัด
✅ `"ผมเคยอ่านว่า Codex 55% แต่ยังไม่ได้ verify"` — 1 frame, ชัด

### 32.7 Name-Dropping Discipline (v2.2)

Never name-drop a brand/company/paper for authority when it cannot be verified:

❌ `"Google, Microsoft, และ MIT ต่างก็ศึกษา..."` — 3 names ไม่มี paper
❌ `"ตามที่ Stanford 2023 study พบ..."` — paper ที่จำไม่ได้
✅ `"<author> <year> (arxiv:<id>) — Codex 55% บน HumanEval"`

**If you name-drop, you need:**
1. A paper/URL/link
2. Or a "claim I once heard" framing + a clear hedge

### 32.8 Over-Formal Address in Casual Text (v2.2)

Very formal address (`ท่าน`, `ท่านผู้อ่าน`, `ข้าพเจ้า`, `กระผม`) in chat, standup or a dev doc reads stiff, an AI tell:

❌ `"หวังว่าจะเป็นประโยชน์ต่อท่านผู้อ่าน"` — ไม่มีใครเขียนแบบนี้ใน Slack
✅ drop the line: in Slack the message ends at its last fact (§40)

**Rule:** match the address to the register. `ท่าน` is not royal language: it is the very formal address that legal notices, privacy and PDPA text, and bank or government letters use correctly, so it stays there. Chat, standup, UI and dev docs use `คุณ` (an instruction) or `เรา` (a concept), or drop the subject. Royal language (ราชาศัพท์) is a separate vocabulary (`ทรง` + verb, royal nouns) that belongs only in text about the royal family. (Corrected 2026-11-09 after chakrit/kien-thai and Boom-Vitt/claude-thai-skills, both MIT.)

### 32.9 Hallucination Context Switch (v2.2)

When AI "context switches" from a verifiable claim → an unverifiable one → drop the whole clause:

❌ `"Postgres trigger ใช้ `pg_notify` แล้ว Redis เคย benchmark 55% บน HumanEval"`
   — `pg_notify` is verifiable, "55% HumanEval" is not, **drop the whole clause**

✅ `"Postgres trigger ใช้ `pg_notify`"`
   — all verifiable

### 32.10 Anti-Fabrication Cheat Sheet (v2.2)

**Before writing any fact → check 3 questions:**
1. **Can it be verified?** → if not: T1 DROP
2. **Is there a source?** → if not: T2 HEDGE or T1
3. **Can the reader verify it onward?** → if not: T1

**Default = T1.** Whenever in doubt → T1.

### 33. Connective Density (Thai Connector Cluster)

**Problem:** AI Thai text stacks formal connectors back to back until the rhythm of natural speech/writing is gone.

**Red-flag connectors (v2.2):**

| Tier | Connector | Replace with |
|------|-----------|--------------|
| **Over-formal** | `"อย่างไรก็ตาม"` | `"แต่"` / `"ก็"` / sentence break |
| **Over-formal** | `"นอกจากนี้"` | `"แล้วก็"` / `"อีกอย่าง"` / new paragraph |
| **Over-formal** | `"ในขณะเดียวกัน"` | `"ตอนเดียวกัน"` / restructure |
| **Over-formal** | `"ในยุคปัจจุบัน"` | `"ตอนนี้"` / drop |
| **Over-formal** | `"ทั้งนี้"` | drop or rephrase |
| **Over-formal** | `"โดยเฉพาะอย่างยิ่ง"` | `"โดยเฉพาะ"` / `"ยิ่งกว่านั้น"` |
| **Over-formal** | `"โดยทั่วไป"` | `"ส่วนใหญ่"` / `"ปกติ"` |
| **Over-formal** | `"ดังนั้น"` (ติดๆ) | `"เลย"` / `"ก็"` / sentence break |
| **Relative glue** | `"ซึ่ง"` chained | `"ที่"` for a concrete noun, or split the sentence. Max one ซึ่ง per sentence |
| **Means glue** | `"โดยที่... โดยใช้... โดยมี..."` | `"ผ่าน"` / `"ด้วย"` / `"จาก"` / nothing. Max one โดย per paragraph |
| **Contrast calque** | `"ในขณะที่"` for contrast | `"แต่"` / `"ส่วน"` / `"กลับ"` (`ในขณะที่` is mainly temporal) |

**Density rule:** ≤1 over-formal connector per paragraph. ≥2 = AI tell.

❌ `"อย่างไรก็ตาม ในขณะเดียวกัน ทั้งนี้ ระบบก็ทำงานปกติ"`
✅ `"แต่ระบบก็ยังทำงานปกติ"`

❌ `service นี้รับ event ซึ่งมาจาก Kafka ซึ่งถูก publish โดย order service ซึ่ง deploy แยก`
✅ `service นี้รับ event จาก Kafka ที่ order service publish มา (order service deploy แยก)`

❌ `ในขณะที่ staging ใช้ Postgres 15 production ยังเป็น 13`
✅ `staging ใช้ Postgres 15 แต่ production ยังเป็น 13`

The ซึ่ง, โดย and ในขณะที่ rows: Adapted from chakrit/kien-thai (MIT), `references/ai-tells.md`, `references/style-rules.md`. Closing particles (`ด้วย`, `แล้ว`, `เลย`) are never budgeted here; see §46.

### 34. Lexical Budget — Same Word, Not Synonym Spam

**Problem:** AI text variety-hacks by using 2-3 synonyms of the same word in one paragraph. Real people repeat the word.

**Rule:** repeating the same word is fine; do not "variety-hack" with odd synonyms.

❌ `"ระบบมีปัญหา (system issue) เพราะ platform ล่ม (down) และ infrastructure ล้มเหลว (failed)"`
✅ `"ระบบล่ม สาเหตุน่าจะมาจาก infra"`

**Thai variant:** `"ระบบล่ม" / "ระบบ down" / "platform เข้าไม่ได้"`: use 1-2 of them, not all 3 in one paragraph

### 35. Topic-First vs Background-First (Standup Register)

**Problem:** AI opens a paragraph with background/context before the topic. Real people start at the topic.

❌ `"เมื่อวานทำงานหลายอย่าง รวมถึง TP-549 ที่ต้องแก้ measurement design และ merge PR #36 เข้า develop วันนี้เลย refocus ที่ TP-549"`
   — 3 clauses of background, topic last

✅ `"TP-549 measurement design เริ่มแล้ว PR #36 merge แล้ว"`
   — topic first, then detail

**Standup order (v2.2):**
1. **✅ Done** (ordered by priority: critical → nice)
2. **🎯 Next** (what you will do today/tomorrow)
3. **🚧 Blocker** (waiting on whom/what)
4. **🙋 Ask** (need an opinion/answer)

### 36. Marketing Calques (UI/Notification Register)

**Problem:** AI UI text uses marketing calques that leave the user unsure what to do.

**Top marketing calques (v2.2):**

| ❌ Calque | ✅ UI-actual |
|-----------|-------------|
| `"ครอบคลุมทุกความต้องการ"` | drop หรือ `"ครบทุก feature ที่ใช้บ่อย"` |
| `"มอบประสบการณ์ที่ดีที่สุด"` | drop |
| `"ส่งมอบคุณค่า"` | drop |
| `"เจาะลึก"` | `"ดู detail"` |
| `"ขับเคลื่อน"` | drop หรือ verb จริง |
| `"ยกระดับ"` | drop หรือ verb จริง |
| `"ก้าวสู่"` | drop |
| `"เปิดรับ (ข้อเสนอแนะ)"` | `"รับ feedback"` |

**UI block max 3 short sentences.** No marketing emoji.

### 36.1 UI-Actual vs UI-Aspirational (v2.2)

Tell them apart:
- **UI-actual**: says what happened + what the user does next
- **UI-aspirational**: says the system is "good" but does not help the user do anything

❌ `"เรามุ่งมั่นมอบประสบการณ์ที่ดีที่สุด"` (UI-aspirational)
✅ `"ชำระเงินไม่สำเร็จ ลองใหม่อีกครั้ง หรือเช็คยอดเงิน"` (UI-actual)

### 37. Nominalization Avoidance

**Problem:** AI turns verbs into nouns to "sound formal"; real people use the verb.

❌ `"การดำเนินการปรับปรุงประสิทธิภาพ"` — nominalization overload
✅ `"ปรับให้เร็วขึ้น"` — verb-first

**Common Thai nominalizations to watch:**
- `"การดำเนินการ"` → `"ทำ"` / drop
- `"การปรับปรุง"` → `"ปรับ"`
- `"การพัฒนา"` → `"พัฒนา"` (already a verb)
- `"การใช้งาน"` → `"ใช้"`
- `"การทดสอบ"` → `"ทดสอบ"`

**Padding shapes to watch** (Adapted from chakrit/kien-thai (MIT)):
- `ทำการ` + a Thai verb → bare verb: `ทำการติดตั้ง` → `ติดตั้ง`; a stacked `การทำการ` always goes. `ทำการ` + an English verb (`ทำการ deploy`) is common in real Thai dev writing; trim it only when the passage is already heavy.
- `มีความ + adj` → bare adjective: `มีความซับซ้อน` → `ซับซ้อน`. Exception: `เป็นความ + verb` (`เป็นความตั้งใจ`) is required grammar; keep it.
- `ที่มี(ความ) + quality` → noun compound: `cluster ที่มีขนาดใหญ่` → `cluster ขนาดใหญ่`
- `การที่ X ทำให้ Y` → make X the topic, give it a real verb (§43)
- `ของ` chains → juxtapose: `การตั้งค่าของ cluster ของทีม` → `config cluster ของทีม`

❌ `ทีมได้ทำการวิเคราะห์แล้วพบว่า query ตัวนี้มีความช้าและมีความสิ้นเปลือง`
✅ `ดูแล้ว query ตัวนี้ทั้งช้าทั้งเปลือง`

### 38. Code-Switching Tells (Mixed Thai/English)

**Problem:** AI uses an English term "because it sounds smart"; real people use it because they need it.

**Rule:** use English when:
1. **The term is used in real work** (`merge`, `deploy`, `staging`, `commit`, `PR`, `API`)
2. **Library/framework name** (`React`, `Bun`, `Postgres`, `Tailwind`)
3. **The concept has no Thai word, or the translation drifts** (`webhook`, `middleware`, `race condition`)

❌ `"ระบบมี redundant ของข้อมูล"` — "redundant" ที่ไม่จำเป็น
✅ `"ข้อมูลซ้ำซ้อน"`

❌ `"Initialize ระบบใหม่"` — Thai "init/เริ่มต้น" ก็ได้
✅ `"init ระบบ"`

**Discourse-marker calques (English → Thai, not English-leak):**

| ❌ Calque | ✅ Better |
|-----------|-----------|
| `"อย่างไรก็ตาม"` (translation of "however") | `"แต่"` / sentence break |
| `"นอกจากนี้"` (translation of "furthermore") | `"อีกอย่าง"` / new para |
| `"เพื่อที่จะ"` (translation of "in order to") | `"เพื่อ"` / drop |
| `"เนื่องจากว่า"` (translation of "due to the fact that") | `"เพราะ"` / `"เนื่องจาก"` |
| `"ในกรณีที่"` (translation of "in the case that") | `"ถ้า"` / `"หาก"` |

**Discourse-marker calques** (Adapted from chakrit/kien-thai (MIT)):

| ❌ Calque | ✅ Better |
|---|---|
| `"ในเรื่องของ X"` / `"ในส่วนของ X"` ("regarding") | drop, or `"ส่วน X"` |
| `"ไม่ว่าจะเป็น A, B หรือ C"` (catalog list) | bare list `"A B หรือ C"`, or `"ทั้ง A B และ C"` |
| `"หนึ่งใน X ที่ดีที่สุด"` ("one of the best") | `"X ที่ดีที่สุดตัวหนึ่ง"`, or the specific claim |
| `"ถูกพิจารณาว่าเป็น"` ("is considered") | `"ถือว่า"` / `"นับว่า"` |
| `"มันเป็นที่ชัดเจนว่า"` (dummy "it") | `"ชัดเจนว่า"` / `"เห็นได้ชัดว่า"` |
| `"สำหรับผมแล้ว ผมคิดว่า"` | `"ผมคิดว่า"` |

❌ `ในส่วนของ auth ไม่ว่าจะเป็น login, refresh หรือ logout ล้วนผ่าน gateway`
✅ `auth ทั้ง login refresh และ logout ผ่าน gateway หมด`

**Bind the English verb to a Thai object, not an English nominal in Thai padding** (Adapted from chakrit/kien-thai (MIT)): `deploy โค้ด`, `query ตาราง`, `scale ระบบ`.
❌ `ทำการ deployment ของ service ใหม่` ✅ `deploy service ใหม่`

**ถูก / โดน** (Adapted from chakrit/kien-thai (MIT)): `โดน` is colloquial and adversative (`โดนแฮก`, `โดน rate limit`). `ถูก` is the milder, formal passive and is fine in neutral formal text (`ข้อมูลถูกเข้ารหัสก่อนบันทึก`, §31's `ถูกปฏิเสธ`). The tell is a chain of passives with the agent tacked on by `โดย` when the agent is known: recast that active.
❌ `log จะถูกเก็บโดย agent แล้วถูกส่งต่อโดย collector ไปยัง storage`
✅ `agent เก็บ log แล้ว collector ส่งเข้า storage`

**Grammar calques from translation** (Adapted from Boom-Vitt/claude-thai-skills (MIT)): the "we are excited to" frame (`พวกเราตื่นเต้นที่จะ...`), articles turned into words (`หนึ่ง`, `อันนั้น` for "a"/"the"), English plural thinking on Thai nouns. Thai counts with a classifier (`3 เครื่อง`, §53) and announces with `มาแล้ว` / `เปิดให้ใช้แล้ว`.
❌ `พวกเราตื่นเต้นที่จะประกาศฟีเจอร์ใหม่หนึ่งตัว: dark mode`
✅ `dark mode มาแล้ว`

**Idiom and formula calques** (Adapted from Boom-Vitt/claude-thai-skills (MIT)): an English idiom translated word for word (`ทำลายน้ำแข็ง` for "break the ice", `ในตอนท้ายของวัน` for "at the end of the day") or an English condolence formula translated literally reads machine-made. Use the Thai formula (`ขอแสดงความเสียใจด้วย`) or say the point plainly (`สรุปคือ`).

### 39. Register-Specific Tells (Per-Register Deep-Dive)

#### 39.1 Register A — Chat/LINE

**Tells:**
- `555` (laughter) at least once
- Reaction emoji (`👍`, `🙏`, `😂`) mixed in
- Particle: `ค่ะ` (female) / `ครับ` (male) / `จ้า` (female, informal) / no particle (assertive)
- 1-10 words per message
- Abbreviations: `อ่อ`, `จ้า`, `จริงดิ`, `555+`, `เหรอ`, `คับ` (informal `ครับ`)

❌ `"สวัสดีค่ะ ดิฉันหวังว่าข้อความนี้จะเป็นประโยชน์ค่ะ"` — formal, AI
✅ `"สวัสดีค่ะ พอดีมีเรื่องอยากถาม"` — natural chat

**Human signals to keep** (Adapted from Boom-Vitt/claude-thai-skills (MIT)): vowel stretching (`ได้แล้วววว`), 555 that grows with the joke, softeners (`น้า`, `เนอะ`, `ป่ะ`, `อ่ะ`). Leave them when the user's draft has them; adding them mechanically, one per line, is itself a tell. In written D they mostly drop.
❌ `ได้ค่ะ 555 เดี๋ยว merge ให้ค่ะ 555 ขอบคุณค่ะ`
✅ `ได้เลยยย เดี๋ยว merge ให้ 555`

**Emoji by function** (Adapted from Boom-Vitt/claude-thai-skills (MIT)): in Thai A, and in a human customer reply (§57), 🙏 is a working softener (thanks, sorry, please), not decoration; once per reply. A bare 👍 reads cold. More than about five emoji in a short message is a tell. Never 🤣 or 555 to someone who is complaining, and no cheerful emoji (😊 🎉) to an upset customer, in an incident or outage message, or in condolences. B, C (system strings) and D stay at zero (cue #18).

#### 39.2 Register B — Standup/PR/Commit

**Tells:**
- No particle (`ครับ`/`ค่ะ`) on every line
- No emoji in the PR description (commit = `type(scope): message`)
- Short words: `ผ่าน`, `รอ`, `merged`, `shipped`, `rolled back`, `WIP`
- Verbatim repo/PR/branch names
- Filter scope: dev own work

❌ `"วันนี้ดิฉันได้ทำการปรับปรุงระบบ API ค่ะ"` — formal, AI
✅ `"ปรับ API แล้ว"`

**Release notes** (Adapted from chakrit/kien-thai (MIT)): no first person; lead with the change and an active verb; close on the version or date. The `พอ` opener (§44) suits chat and docs, not release notes.

#### 39.3 Register C — UI/Error/Notification

**Tells:**
- 1-3 sentences per block
- ≤25 words
- One opener with `ค่ะ/ครับ` only
- Action verb + 1 alternative (`ลอง X หรือ Y`)
- Status word first: `"ชำระเงินไม่สำเร็จ"`, `"บันทึกแล้ว"`, `"ยกเลิกเรียบร้อย"`
- No "หวังว่า", "ขออภัย", "แจ้งให้ทราบ", "ยินดีให้ความช่วยเหลือ"

❌ `"ขออภัยในความไม่สะดวกค่ะ เราจะพยายามปรับปรุงให้ดีขึ้น"` — apology and promise, no status, no action
✅ `"ชำระเงินไม่สำเร็จ ลองใหม่อีกครั้ง หรือเช็คยอดเงินค่ะ"` — UI-actual

#### 39.4 Register D — Prose/Blog/Strategy/Essay

**Tells:**
- 3-30 words per sentence, alternating rhythm
- Personal aside (`ผมเคย`, `ผมรู้สึกว่า`, `ผมไม่แน่ใจว่า`)
- Concrete image instead of abstraction
- No "หวังว่าจะเป็นประโยชน์" closer
- No "อนาคตสดใส", "ก้าวต่อไปจะเป็นการเดินทางสู่ความเป็นเลิศ"

❌ `"ในยุคปัจจุบัน AI กำลังเปลี่ยนแปลงโลกอย่างมาก ซึ่งส่งผลกระทบต่ออุตสาหกรรมต่าง ๆ"`
   — formal connector spam, generic claim

✅ `"AI เขียนโค้ดเก่งขึ้นทุกปี ผมยังนึกถึง agent ที่เขียนผ่านมาทั้งคืน แต่ครึ่ง dev community ก็ยังบอกว่ามันนับไม่ได้"`
   — opinion, image, mixed rhythm

**Register drift** (Adapted from chakrit/kien-thai (MIT)): pick the casual or the formal column for a whole passage and stay there; a switch mid-paragraph reads as AI (a heading break is fine). Pairs: `ยังไง`/`อย่างไร`, `เยอะ`/`มาก`, `ทำไม`/`เพราะเหตุใด`, `ตอนนี้`/`ขณะนี้`, `แบบไหน`/`แบบใด`, `อยากรู้`/`ต้องการทราบ`.
❌ `ตั้งค่ายังไงให้ worker รับโหลดได้เยอะ และควรเลือก instance แบบใด`
✅ `ตั้งค่ายังไงให้ worker รับโหลดได้เยอะ แล้วควรเลือก instance แบบไหน`

**Reader address in READMEs and guides** (Adapted from chakrit/kien-thai (MIT)): address the reader as `คุณ` or drop the subject; don't swap in a category noun (`ผู้ใช้`, `นักพัฒนา`) as the 2nd person in body text (category nouns belong in headings). Don't mix `เรา` and `คุณ` in one paragraph: `เรา` to teach a concept, `คุณ` for the instruction.
❌ `ขั้นตอนนี้ช่วยให้นักพัฒนาตั้งค่า env ได้เร็วขึ้น`
✅ `ขั้นตอนนี้ช่วยให้คุณตั้งค่า env ได้เร็วขึ้น`

**Structure:** for D prose (and long B), run `patterns-thai-structure.md` §43-§52 before this lexical pass; many §33 and §37 tells disappear once the sentence shape is Thai.

### 40. AI-Leaked Thai Closers (v2.2 — Comprehensive)

**Closers to drop in every register:**

| Closer | Register | Replace with |
|--------|----------|--------------|
| `"หวังว่าจะเป็นประโยชน์"` | A, D | drop |
| `"หวังว่าพอเป็นประโยชน์"` | A, D | drop |
| `"ดีใจที่ได้ช่วย"` | A, D | drop |
| `"ยินดีให้ความช่วยเหลือค่ะ"` | A, C, D | drop |
| `"แจ้งให้ทราบ"` | A, B, C, D | drop |
| `"หากต้องการขยายความ"` | A, D | drop |
| `"ขอบคุณคำถามดีๆ ค่ะ"` | A, D | `"ขอบคุณค่ะ"` / drop |
| `"Let me know if you need more"` | D | drop |
| `"If you need further assistance"` | A, C, D | drop |
| `"Feel free to reach out"` | A, D | drop |
| `"สามารถติดต่อเราได้ตลอด 24 ชั่วโมง"` | C | drop |
| `"หากมีข้อสงสัยประการใด กรุณาติดต่อ..."` | C | drop |
| `"เราพร้อมให้บริการ"` | C | drop |

**Guard: politeness is not a tell** (Adapted from chakrit/kien-thai (MIT)). Ordinary politeness and softeners (`รบกวน`, `ขอ`, `ให้`, `นะ`, `ช่วย...หน่อย`) are native baseline; stripping them makes Thai curt (`ห้วน`). The tell is politeness above the register (a formal closer in chat, `ท่าน` in Slack) or the same polite formula on every line.

**Openers to drop in every register** (Adapted from chakrit/kien-thai (MIT)): `ในโลกปัจจุบัน`, `ในโลกที่...`, `เป็นที่รู้กันว่า`, `เป็นสิ่งสำคัญที่ต้องตระหนักว่า`, and an exclaimed `นั่นเอง!`.

**Particle decision table (v2.2):**

| Register | Opener particle | Closer | Note |
|----------|-----------------|--------|------|
| A (chat, female) | `ค่ะ` / `จ้า` / no | `ค่ะ` / `นะคะ` | ไม่ลงท้ายทุกประโยค |
| A (chat, male) | `ครับ` / no | `ครับ` / `นะครับ` | ไม่ลงท้ายทุกประโยค |
| B (standup) | no | no | terse = AI detection < human |
| B (PR/commit) | no | no | conventional commit format |
| C (UI, formal) | `ค่ะ`/`ครับ` (1 opener) | no | ไม่ลงท้ายทุกประโยค |
| C (UI, casual app) | no | no | match brand voice |
| D (essay) | no | no | particle ทื่อๆ = AI tell |
| D (personal blog) | `ครับ`/`ค่ะ` in the greeting only | sign-off only | body none; `ผม`/`ดิฉัน` or `เรา`, follow the author's sample |
| C (human reply to a customer) | `ค่ะ`/`ครับ` | `ค่ะ`/`ครับ` on most sentences; `นะคะ`/`นะครับ` to soften | a live conversation, not a string; a bare sentence reads curt; see §57 |

Personal-blog row: Adapted from chakrit/kien-thai (MIT) (`references/register.md`). ADR, README and strategy docs stay at zero particles.

**Particle slips** (Adapted from Boom-Vitt/claude-thai-skills (MIT)): `คะ` marks a question and `ค่ะ` a statement; mixing them up is a tell. Bare `นะ` with no `ค่ะ`/`ครับ` is too casual for anything customer-facing.

### 41. Over-Formal Address (pointer)

See §32.8. §41 stays as a numbered pointer so catalog numbers never shift.

### 42. Quick Reference — Thai-Specific Patterns (sub-patterns listed beneath)

| # | Name | When |
|---|------|------|
| §32.1 | Anti-fabrication 3-tier tree | ทุก register (default T1) |
| §32.2 | Red-flag patterns catalog | เจอ path/date/metric ที่ดูดีเกิน |
| §32.3 | Cite-as-published | T3 cite |
| §32.4 | Thai hedge vocabulary | เขียน T2 |
| §32.5 | Citation conventions | internal doc cite |
| §32.6 | Epistemic frame | เขียน uncertainty |
| §32.7 | Name-dropping discipline | อ้าง brand/paper |
| §32.8 | Over-formal address | match register |
| §32.9 | Hallucination context switch | เขียน claim ผสม |
| §32.10 | Anti-fabrication cheat sheet | quick lookup |
| §33 | Connective density | formal connector cluster |
| §34 | Lexical budget | synonym spam |
| §35 | Topic-first | standup/chat opener |
| §36 | Marketing calques | UI/notification |
| §36.1 | UI-actual vs aspirational | UI text |
| §37 | Nominalization | formal writing |
| §38 | Code-switching tells | mixed register |
| §39 | Register-specific tells | 4 register deep-dive |
| §40 | AI-leaked closers | closers + particle |
| §43-§52 | Sentence and paragraph structure | D prose, long B (`patterns-thai-structure.md`) |
| §53 | Surface grammar slips | every genre |
| §54 | Headings | D |
| §55 | Pronouns and self-reference | every genre |
| §56 | Dates, times and numbers | C, public D |
| §57 | Apology and promises | human customer replies |
| §58 | Hidden characters and marks | any edited prose |

---

## ADDED PATTERNS (§53-§58)

### 53. Surface Grammar Slips

Adapted from chakrit/kien-thai (MIT), `references/grammar.md` and `references/ai-tells.md`. Word-level errors that read as foreign-fluent. Every genre.

- **Classifier.** Counting a noun needs its own classifier; AI defaults to `ใบ` or drops it. Tech nouns: `เครื่อง` (server, device), `ตัว` (function, variable, instance, param), `อัน` (token, record, generic), `บรรทัด` (line), `รายการ` (entry, transaction), `หน้า` (page). Unsure → drop the count.
  ❌ `สร้าง VM ใหม่ 3 ใบ` ✅ `สร้าง VM ใหม่ 3 เครื่อง`
- **Missing จะ.** English present covers future and modal; Thai marks it with `จะ`.
  ❌ `ใช้ batch size เท่าไหร่ขึ้นกับ RAM ของ node` ✅ `จะใช้ batch size เท่าไหร่ขึ้นอยู่กับ RAM ของ node`
- **Look-alike function words.** `จะ` (will) vs `จน` (until); `เหมาะ` needs `กับ`.
  ❌ `เหมาะงานที่ต้อง retry` ✅ `เหมาะกับงานที่ต้อง retry`
- **Verb calque.** Idiomatic-physical English verbs (burst, drop, cap, throttle) rarely map to the literal Thai verb.
  ❌ `ระบบจะบีบ request ที่เกินโควตา` (throttle) ✅ `request ที่เกินโควตาจะโดนหน่วงไว้ก่อน`
- **Numbers take thinking verbs.** A quantity pairs with `คาด` / `ประเมิน`, not `รู้สึก`; two numbers that match are `ตรงกัน`, not `ซ้ำกัน`.
  ❌ `ขนาด bundle ไม่เหมือนที่รู้สึกไว้` ✅ `ขนาด bundle ไม่ตรงกับที่ประเมินไว้`
- **"Can" follows the register.** Formal or user-facing: `สามารถ + verb + ได้` (`สามารถยกเลิกได้ทุกเมื่อ`). Casual or internal: `verb + ได้` (`ยกเลิกได้`). Never drop `ได้` where the ability is the point.
- **Conditions in specs.** "Only then" is `ถึงจะ` (`ต้องมีคน approve ก่อน ถึงจะ merge ได้`). `ก็ต่อเมื่อ...ได้` can read as permission rather than an automatic step, so check which one the spec means.
- **A bare `เมื่อไหร่` needs a closer.** `X เมื่อไหร่ Y` alone reads unfinished; close it (`ทันที`, `ก็...เลย`).
  ❌ `test ผ่านเมื่อไหร่ merge` ✅ `test ผ่านเมื่อไหร่ merge ทันที`
- **ทีไร vs ไม่ว่าจะ...เมื่อไหร่.** "Whenever" splits in Thai. `ทีไร` (each time, often frustration) needs a closure (`ทุกที`, `ไม่เคย...สักที`) and no `ก็`. `ไม่ว่าจะ...เมื่อไหร่` (any time, a guarantee) needs `ก็จะ`.
  ❌ `rerun ทีไร test ก็ fail` ✅ `rerun ทีไร test fail ทุกที`
  ❌ `ไม่ว่าจะ deploy เมื่อไหร่ health check ผ่าน` ✅ `ไม่ว่าจะ deploy เมื่อไหร่ health check ก็จะผ่าน`

### 54. Headings

Adapted from chakrit/kien-thai (MIT), `references/style-rules.md` and `references/craft.md`. Genre D.

Question heading when the body answers it (`ทำไมต้องแยก pipeline`), declarative when the body elaborates (`ตอนที่ queue ค้างทั้งคืน`). Thai headings run shorter than English; don't translate "How X shapes Y" into `วิธีที่ X ส่งผลต่อ Y`. `X คือ...` as the first sentence is the SEO default; keep it for reference docs where the definition is the point.

### 55. Pronouns and Self-Reference

Adapted from Boom-Vitt/claude-thai-skills (MIT), `skills/thai-translate`, `skills/thai-customer-service`, `skills/thai-social-caption`.

Thai has no neutral I/you, so a wrong pronoun reads machine-made even when every word is right.
- `ดิฉัน` in chat or standup is too stiff (it is formal 1st person). In A use `เรา`, the writer's own `ผม`/`ฉัน`, or no pronoun.
- `คุณ` for every "you" sounds cold in A. Use `พี่`/`น้อง` + name, or just the name. (In a README, `คุณ` is right: §39.4.)
- Product voice: pick one "we" (`เรา`, `ทีมงาน` or `ทางบริษัท`) and keep it for the whole thread or screen set.
- Don't mix registers in one paragraph (`ข้าพเจ้า` next to `แก`). Never `กู`/`มึง` in a brand or product voice.
- Customer address: default `คุณลูกค้า` (a bare `ลูกค้า` as "you" reads curt); `คุณ` + name when known; `พี่`/`น้อง` only when the customer set that tone. Keep one form for the whole thread.
- Once a passage addresses the reader, even implicitly, keep addressing them; don't slip to `ใคร`/`คน`/`ใครๆ` for the same person. (Adapted from chakrit/kien-thai (MIT).)

❌ `ดิฉันได้ทำการ deploy แล้วค่ะ คุณลองเช็คได้เลยค่ะ` (to a teammate)
✅ `deploy แล้วนะ ลองเช็คได้เลย`
❌ `ทางบริษัทได้รับเรื่องแล้ว เราจะแจ้งทีมงานของเรา` (three "we" forms)
✅ `ทีมงานรับเรื่องแล้วค่ะ ถ้ามีความคืบหน้าจะแจ้งในเธรดนี้`

### 56. Dates, Times and Numbers

Adapted from Boom-Vitt/claude-thai-skills (MIT), `skills/thai-date-format`.

Internal dev writing (B, internal D) uses ISO dates on the CE calendar (`2027-02-03`, `09:30`). User-facing Thai (C, public D) uses:
- the BE year with the month in letters: `3 กุมภาพันธ์ 2570`, or `3 ก.พ. 70` in casual copy;
- slashes only in tables (`03/02/2570`), not in prose;
- 24-hour time with a dot, both parts zero-padded, one space, then `น.` (`09.30 น.`), never a colon and never AM/PM; clock words (`บ่ายสอง`, `สองทุ่ม`) are fine in chat, wrong in UI and official text;
- one era and one script per date: `3 February 2570`, or `๓` beside an Arabic year, reads machine-made;
- a deadline needs a start point in specs, SLAs and notices: `ภายใน 7 วันนับจากวันที่ได้รับอีเมล`, not a bare `ภายใน 7 วัน` (Adapted from chakrit/kien-thai (MIT)).

Numbers in user-facing copy: phone numbers grouped (`08X-XXX-XXXX`, or `+66 8X XXX XXXX`); money with a thousands separator and `บาท` (`1,250 บาท`), saying whether VAT is included when a price is quoted; no `!` in formal Thai.

Mixing the two systems, or adding 543 to a year that is already BE, is a tell and a fabrication risk (§32). If you can't tell which era the source year is in, don't convert it.

❌ `ปิดปรับปรุงระบบ 03/02/2027 1:00 AM - 3:00 AM`
✅ `ปิดปรับปรุงระบบวันที่ 3 กุมภาพันธ์ 2570 เวลา 01.00–03.00 น.`

### 57. Apology and Promises (Human Customer Replies)

Adapted from Boom-Vitt/claude-thai-skills (MIT), `skills/thai-customer-service`.

For a person or brand replying to a customer (support chat, incident notice, status page). A UI or error string is §39.3 instead.
- Size the apology to the harm. Small delay: `ขออภัยค่ะ`. Our own fault: `ขอโทษที่...`. Major incident: `ขออภัยอย่างสูง` plus what happens next. The strong form on a small issue wears it out. `ขออภัยในความไม่สะดวก` is the standard phrase for a small inconvenience and fine there; it becomes the tell when it is the whole reply, with no status and no next step.
- `ขออภัย` when we caused it; `ขอแสดงความเสียใจ` when a third party did (bank, courier, cloud provider). Don't accept fault before the evidence.
- A response time or refund the team can't confirm is fabrication (§32.1, T1). Say what you will check, not the result.
- Empathy first, then the fix, short. Never defensive (`ก็แจ้งไว้แล้ว`, `ตรงนี้ทางเราไม่เกี่ยวนะคะ`).
- A refusal gives the policy reason and one alternative. A canned reply that doesn't answer the customer's actual question is a tell. Don't open with a bare thanks to a customer who is still angry. Every reply ends with the next step: what happens, or what the customer can do.

❌ `ขออภัยอย่างสูงในความไม่สะดวกค่ะ ทีมงานจะแก้ไขให้ภายใน 5 นาทีค่ะ` (for a slow OTP)
✅ `ขออภัยค่ะ ตอนนี้ OTP ส่งช้ากว่าปกติค่ะ ทีมงานกำลังตรวจสอบอยู่ ได้ข้อมูลแล้วจะแจ้งในแชทนี้นะคะ`

### 58. Hidden Characters and Marks

Adapted from Boom-Vitt/claude-thai-skills (MIT) (`skills/thai-text-processing`, `skills/thai-date-format`) and Adapted from chakrit/kien-thai (MIT) (`references/style-rules.md`, `references/ai-tells.md`).

- Remove the zero-width space (U+200B) from prose you edit; CMS and copy-paste insert it and it breaks search and wrapping. Code blocks stay byte-identical.
- Normalize decomposed tone marks from old systems to NFC.
- `ๆ` belongs to the word before it: never a line break between them. `ต่าง ๆ` takes the space. Other `ๆ`: casual dev text usually glues it (`ง่ายๆ`), formal docs space it (`ง่าย ๆ`). Follow the document's existing form and keep one form per piece; never "correct" a chat or standup writer's form.
- Keep the dots in Thai abbreviations: `ม.ค.`, `น.`, `พ.ศ.`.
- Apposition by space, not comma: `Redis ตัวที่ใช้เป็น cache ตอนนี้...`, not `Redis, ตัวที่ใช้เป็น cache, ...`.
- Thai rarely italicizes for emphasis; use a particle or word order (`ตัวนี้แหละที่...`).
