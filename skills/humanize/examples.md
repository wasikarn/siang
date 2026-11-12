# Worked Examples (extends SKILL.md)

## Contents

- Full example
- Grit gate: soulless vs alive
- Per-register worked examples
- Monolingual English examples

> Worked applications of the patterns in `patterns-universal.md`, `patterns-thai.md` and `patterns-thai-structure.md`, full loop: draft → "still-AI" bullets → final rewrite. Use as a reference when stuck.
>
> ❌/✅ below = bad/good notation, not the decorative emoji §18 tells you to cut from real writing.
>
> **Language coverage:** Examples A–D below are Thai (or Thai↔EN mixed). The section after the side-by-side table covers **monolingual English** so the same rules apply when no Thai is in the draft.

---

## Full Example

**Before (AI-sounding, Thai mixed; a team post about a trial of an AI review bot):**
> ขอบคุณที่ถามครับ เป็นคำถามที่ดีมาก! ด้านล่างคือสรุปผล pilot ที่ขอมา หวังว่าจะช่วยได้นะครับ!
>
> Our four-week pilot of the AI review bot on the `api` repo stands as a landmark chapter in our engineering journey, reflecting a broader shift ใน ecosystem ของ developer tooling ที่เปลี่ยนเร็วมาก. The bot—deeply woven into every pull request—posted 140 comments, cementing its place as a vital pillar of our review culture.
>
> What the bot brings is simple: sharper reviews, faster merges, and a team that keeps learning. It isn't merely a linter; it's a second pair of eyes. The bot operates as a gatekeeper. The assistant serves as a coach. The tool represents a backstop for every release.
>
> Experts across the industry agree that automated review now covers everything from one-line typo fixes to full schema migrations. Additionally, the team accepted 31 of the 140 comments, and two of them caught real bugs, a missing null check and an off-by-one in pagination, a testament to the pivotal synergy between tooling and the people who use it.
>
> - 🔍 **Signal:** Many comments echoed what lint already catches, pointing to room for growth
> - ⏱️ **Speed:** Review time went unmeasured due to the fact that our focus was on outcomes over metrics
> - 🧭 **Next step:** Keep the bot on `api` and switch it off on `web`, paving the way for a balanced approach
>
> While the rollout was not without its hurdles, the bot keeps going from strength to strength. Moving forward, it might arguably be worth considering whether teams could perhaps adopt a more aligned review process.
>
> โดยรวมแล้ว อนาคตของการ review โค้ดในทีมเราสดใสมาก และนี่เป็นเพียงจุดเริ่มต้นเท่านั้น ถ้าอยากให้เจาะลึกส่วนไหนเพิ่ม บอกได้เลยนะครับ!

**Draft rewrite:**
> ทดลองเปิด AI review bot บน repo `api` สี่สัปดาห์ bot comment ไป 140 ครั้ง ทีม accept 31 มีสองอันที่เจอ bug จริง: null check ที่หายไป กับ off-by-one ตรง pagination
>
> หลาย comment ซ้ำกับที่ lint จับได้อยู่แล้ว ส่วน review time เราไม่ได้วัด
>
> สรุปคือเปิดไว้บน `api` ต่อ ปิดบน `web` เครื่องมือดีแค่ไหนก็แทนคน review ไม่ได้

**What still reads as AI in the draft?**
- Every paragraph is the same length and ends on a neat wrap-up.
- The last line ("เครื่องมือดีแค่ไหนก็แทนคน review ไม่ได้") is a slogan (§60), and worse, an opinion the Before never states. Cut it; don't add claims while cleaning. **For Thai: a closing moral on a Thai team post gives the AI away even sooner than it does in English**
- "สรุปคือ" opens the decision like a template.

**Final rewrite:**
> เปิด AI review bot บน `api` ไปสี่สัปดาห์ bot comment 140 ครั้ง เรา accept 31 ในนั้นมีสองอันที่เป็น bug จริง คือ null check ที่หายไป กับ off-by-one ตรง pagination
>
> หลาย comment ซ้ำกับที่ lint จับอยู่แล้ว review time ไม่ได้วัด เลยบอกไม่ได้ว่าเร็วขึ้นไหม
>
> จะเปิดต่อบน `api` แต่ปิดบน `web`

**Changes made:** Removed the chatbot opener and closer (§20, §22), the significance and trend claims (§1, §5), the promotional words and -ing tails (§3, §4, §7), the copula swaps and the gatekeeper/coach/backstop name cycling (§8, §11), the "isn't merely a linter" contrast (§9), the forced triad (§10), the em dashes, emojis and bold labels (§14–§18), the challenges formula and the hedge stack (§6, §24), the filler (§23) and the upbeat ending (§25). Every fact in the final (four weeks, 140, 31, the two bugs, lint overlap, no timing data, the `api`/`web` decision) is in the Before. Register: §0 dev register, internal team voice, Thai with English terms kept per §31.

---

## Grit Gate: Soulless vs Alive

Same facts, neutral report → real voice. Illustrates `grit.md`'s Grit Gate (surface the grit,
commit to a point of view):

> ❌ การทดสอบ canary สองวันให้ผลลัพธ์ที่น่าสนใจ error rate ไม่เปลี่ยน latency p50 เพิ่มขึ้น 4 ms ทีมบางส่วนพร้อม rollout ขณะที่บางส่วนต้องการรออีกหนึ่งสัปดาห์
> ✅ canary รันมาสองวัน error rate นิ่ง แต่ p50 ขึ้น 4 ms ผมยังไม่แน่ใจว่า 4 ms นี้ยอมได้ไหม ในทีมบางคนอยากปล่อยเลย บางคนขอรออีกสัปดาห์

The point of view ("ผมยังไม่แน่ใจ") came from the author when asked. Don't invent one: ask, or offer it as a suggestion next to the rewrite.

---

## Per-Register Worked Examples (v2.2)

How the register selection gate (`register.md`, §0) + per-register patterns apply.

### Example A — Chat / LINE (Register A)

**Before (AI-sounding — too formal for chat):**
> สวัสดีค่ะ ดิฉันขอเรียนให้ทราบว่าวันนี้ระบบอาจจะมีความไม่เสถียรเล็กน้อย อันเนื่องมาจากการปรับปรุงระบบ backend หวังว่าจะไม่เป็นการรบกวนค่ะ ยินดีให้ความช่วยเหลือหากมีข้อสงสัยค่ะ

**Red flags:**
- `"ดิฉัน"` (formal 1st person, too stiff for chat)
- `"ขอเรียนให้ทราบ"` (formal opener)
- `"อันเนื่องมาจาก"` (translation of "due to the fact that")
- `"ความไม่เสถียรเล็กน้อย"` (vague understatement)
- `"หวังว่าจะไม่เป็นการรบกวน"` (over-formal for a chat between colleagues; a plain `นะคะ` carries the same politeness, §40 guard)
- `"ยินดีให้ความช่วยเหลือหากมีข้อสงสัย"` (AI-leaked closer)

**After (chat register):**
> สวัสดีค่ะ วันนี้ทีมปรับ backend อยู่ ระบบอาจสะดุดบ้างนะคะ ถ้าเจอปัญหาทักมาได้เลยค่ะ 🙏

**Changes applied:**
- Drop the formal 1st person `ดิฉัน` → `ค่ะ` opener (chat register female)
- `backend` kept in English (dev term)
- No duration added: the source gives none, so the rewrite doesn't invent one (§32.1); if the writer knows the window, it goes in
- `ทักมา` action verb (UI-actual)
- 🙏 emoji instead of a formal closer

### Example B — Standup (Register B)

**Before (AI-sounding — too narrative):**
> สวัสดีครับ วันนี้ดิฉันได้ทำการปรับปรุง API endpoint ในส่วนของ measurement redesign รวมถึง merge PR #64 เข้าสู่ develop branch นอกจากนี้ยังได้ review code ของเพื่อนร่วมทีมอีก 2 ท่าน พร้อมทั้งอัปเดต documentation ให้ทันสมัย

**Red flags:**
- `"ดิฉัน"` (formal 1st person, too stiff for a standup)
- `"ได้ทำการปรับปรุง"` (nominalization)
- `"นอกจากนี้ยัง"` (formal connector spam)
- `"เพื่อนร่วมทีมอีก 2 ท่าน"` (vague; no PR, no name)
- `"อัปเดต documentation ให้ทันสมัย"` (vague; which file, which PR)

**After (standup register):**
```
ทำเสร็จ
- measurement redesign: ปรับ API endpoint แล้ว PR #64 merged เข้า develop
- review code ของเพื่อนในทีม 2 คน
- อัปเดต documentation
```

**Changes applied:**
- 1st person implied (drop `ดิฉัน`/`ผม`)
- Verbatim PR number (`#64`) and branch (`develop`)
- Topic-first lines (`measurement redesign:`)
- Particle not on every line (terse)
- The source names no reviewers, review PRs, doc files or next steps, so the rewrite leaves those out instead of inventing them. In a real standup, ask the writer; anything they give (ticket IDs, names) goes in verbatim (§32.1).

### Example C — UI Error Message (Register C)

**Before (AI-sounding — marketing fluff):**
> ขออภัยในความไม่สะดวกค่ะ! การชำระเงินของท่านไม่สำเร็จ อันเนื่องมาจากระบบของธนาคารปฏิเสธการทำรายการ เรามุ่งมั่นมอบประสบการณ์ที่ดีที่สุด และพร้อมให้บริการท่านตลอด 24 ชั่วโมงค่ะ

**Red flags:**
- `"ขออภัยในความไม่สะดวกค่ะ!"` (an apology in place of the status; in a UI string the status comes first, §39.3)
- `"อันเนื่องมาจาก"` (formal connector)
- `"ท่าน"` (very formal address: right in a legal notice, too stiff in a UI string, §32.8)
- `"มุ่งมั่นมอบประสบการณ์ที่ดีที่สุด"` (UI-aspirational, marketing calque)
- `"พร้อมให้บริการท่านตลอด 24 ชั่วโมง"` (UI-leaked closer)

**After (UI-actual):**
> ชำระเงินไม่สำเร็จ
> ธนาคารปฏิเสธรายการค่ะ
> <ขั้นต่อไป: ยืนยันกับทีม product>
> ติดปัญหา: ติดต่อ <ช่องทางของทีม>

**Changes applied:**
- Status word first (`ชำระเงินไม่สำเร็จ`)
- `ธนาคารปฏิเสธรายการ` (active verb; drops the nominalized `การทำรายการ`)
- Next step: the source names none, so the After leaves a placeholder instead of inventing one. `ลองใหม่อีกครั้ง` / `เช็กยอดเงิน` are the usual actions for a bank decline; suggest them to the product team next to the rewrite, not inside it. The contact channel stays a placeholder for the same reason
- At most one `ค่ะ` (UI formal register)
- No English parenthetical in the title (`## การชำระเงิน (Declined)` ❌)
- ≤25 words
- No "ขออภัย", "มุ่งมั่น", "พร้อมให้บริการ"

### Example D — Prose / Blog (Register D)

The Full Example above is a Register D piece. The D-specific fixes in it:
- ❌ `Experts across the industry agree that automated review now covers...` → a trend claim with no named source (§5, vague attribution): ask the writer for the source, or cut it. If the writer has the source, cite it as published: author, year, link (§32.3).
- ❌ `ขอบคุณที่ถามครับ เป็นคำถามที่ดีมาก! ... หวังว่าจะช่วยได้นะครับ!` and `ถ้าอยากให้เจาะลึกส่วนไหนเพิ่ม บอกได้เลยนะครับ!` → drop (§40).
- ❌ a closing moral the source never states (`เครื่องมือดีแค่ไหนก็แทนคน review ไม่ได้`) → cut; cleaning text never adds a claim (§60, §51).
- ❌ `โดยรวมแล้ว อนาคตของ...สดใสมาก` → drop the recap and end on the decision (§51).

### Side-by-Side: Same Content, 4 Registers

Given the draft `ผมได้ merge PR #64 เข้า develop แล้ว measurement redesign เสร็จเรียบร้อย`:

| Register | Rewrite | Why |
|----------|---------|-----|
| **A** (chat) | `"PR #64 merge เข้า develop แล้วครับ measurement redesign เสร็จ 🎉"` | terse, emoji, topic first, every fact kept; the source writes as `ผม`, so `ครับ` |
| **B** (standup) | `"PR #64 measurement redesign merged เข้า develop"` | status + PR + scope |
| **C** (UI) | `"merge สำเร็จ: PR #64 (measurement redesign) → develop"` | status word first, same facts |
| **D** (blog) | `"PR #64 merge เข้า develop แล้ว measurement redesign ก็เสร็จแล้ว"` | full sentence, `ก็` pacing, no added detail |

**Rule:** same fact, different register → different sentence shape, different particle, different length. Use the register the reader is in, not the one that "sounds good".


---

## Monolingual English Examples (v3.0)

Same catalog (33 universal + 28 Thai-specific top-level), but applied to drafts that contain **no Thai**. Useful when the user writes internal EN-only docs, EN UI copy, or EN strategy/blog prose. Universal patterns (§1-§30 and §59-§61 in `patterns-universal.md`) all apply; Thai-specific patterns (§31-§58) are skipped.

### Example E — EN UI Error (Stripe-style)

**Register:** C (UI / error / notification). Language axis: EN. Particle: none.

**Before (AI-sounding — chatbot-flavored):**
> Oops! It looks like your payment couldn't be processed at this time. Don't worry, our team is working diligently to ensure a seamless experience for you. This serves as a testament to our commitment to security. Please try again, and feel free to reach out if you have any questions — we're here to help!

**Red flags:**
- `"Oops!"` + `"It looks like"` — chatbot-flavored, not Stripe-actual
- `"Don't worry"` — sycophantic reassurance
- `"working diligently to ensure a seamless experience"` — promotional padding + AI vocab (`diligently`, `seamless`)
- `"serves as a testament to our commitment"` — significance puffing
- `"feel free to reach out"` — servile closer
- `"— we're here to help!"` — em dash + sycophantic closer

**After (EN UI — register C):**
> Payment failed. Try again.
> Questions? Contact <support channel>.

**Changes applied:**
- Status first (`Payment failed.`)
- The one action the Before gives (`Try again.`)
- The contact channel stays a placeholder: the Before names none, so don't invent an address or a cause such as "card declined"
- No opener, no closer, no "we"
- Under 10 words, short lines (UI-actual density)

### Example F — EN Standup / Slack message

**Register:** B (Standup / PR / commit). Language axis: EN. Particle: none.

**Before (AI-sounding — narrative + puffing):**
> I hope everyone is doing well! I wanted to provide a quick update on the work I completed this week. Notably, I successfully merged PR #847 which represents a pivotal milestone in our migration journey. Additionally, I undertook a comprehensive refactor of the authentication module, showcasing my commitment to code quality. Furthermore, I collaborated with key stakeholders across teams to align on best practices. Looking ahead, I will be leveraging my expertise to drive innovation.

**Red flags:**
- `"I hope everyone is doing well!"` — chatbot opener
- `"successfully merged"` — significance puffing (`successfully` adds nothing)
- `"represents a pivotal milestone"` — §1 emphasis on legacy
- `"undertook a comprehensive refactor"` — nominalization + AI-vocab
- `"showcasing my commitment"` — promotional + -ing ending
- `"collaborated with key stakeholders across teams"` — vague weasel attribution
- `"align on best practices"` — vague-upbeat contentless verb
- `"leverage expertise to drive innovation"` — AI-vocab pileup
- 1st-person throughout (standup author speaks from their own experience, not a narrated CV)

**After (EN standup — register B):**
> Merged PR #847 (migration). Refactored the auth module.
>
> Met <who?> about <which practice?>.
>
> Next: <what?>

**Changes applied:**
- 1st-person implied (drop "I" at sentence start, keep it where ownership is real)
- PR number kept verbatim; the stakeholders, the topic and the next step stay as gaps, because the Before names none of them and the author has to fill them in
- Topic-first (PR #847 / Met / Next:)
- No closer, no "I'm excited", no "leverage"
- Under 20 words

### Example G — EN Prose / Blog (register D)

**Before (AI-sounding — significance + rule of three + vague attribution):**
> Our switch to feature flags serves as a milestone in how the team ships. It isn't only a deployment trick; it's a new way of working that puts confidence first. Many engineers say flag-driven teams end up fostering trust, speed, and ownership across every release. A smoother road lies ahead, and teams willing to embrace change will flourish in the ever-evolving delivery landscape.

**Red flags:**
- `"serves as a milestone in"` — §1 significance + §8 copula avoidance
- `"a new way of working"` — vague-upbeat filler
- `"It isn't only... it's"` — §9 negative parallelism
- `"puts confidence first"` — promotional + rule-of-three bait
- `"Many engineers say"` — §5 vague attribution
- `"fostering trust, speed, and ownership"` — §10 rule of three + §3 -ing ending
- `"A smoother road lies ahead"` — §25 generic positive conclusion
- `"the ever-evolving delivery landscape"` — landscape = §7 AI vocab

**After (EN prose — register D):**
> Feature flags changed <what, for which team> [source or first-hand detail?].

**Changes applied:**
- The Before has no checkable fact, so the rewrite has almost nothing left. That is the finding: ask the author what actually changed and how they know, then write that
- Do not supply an anecdote, a date or a number for them; a made-up "three years after we switched" reads human and is still invented
- No rule of three, no "many engineers say", no "landscape", no slogan ending

### Side-by-Side: Same content, monolingual EN

`"merged PR #847 to develop; auth refactor landed in the same PR; break it into chunks for review next time"`:

| Register | Rewrite | Why |
|----------|---------|-----|
| **A** (chat, EN) | `"PR #847's in 🎉"` | terse, emoji, no detail |
| **B** (standup, EN) | `"PR #847 merged. auth refactor in same PR, chunk next time"` | ticket + scope + improvement |
| **C** (UI, EN) | `"PR #847 merged to develop."` | status-only, no narrator |
| **D** (blog, EN) | `"We merged PR #847 to develop. The auth refactor rode along in the same PR; splitting it up would have made review easier."` | narrative, first-person, hindsight |
