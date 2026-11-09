# Universal AI-writing patterns (§1–§30, §59–§61): full catalog

## Contents

- Content patterns
- Language and grammar patterns
- Style patterns
- Communication patterns
- Filler and hedging
- Reader and argument patterns (§59–§61)
- Detection guidance

The 33 universal patterns, with the problem and a worked before/after for each.
These apply to **all languages** (EN, TH, mixed). The compact 33-row table is
`cue-sheet.md`; open this file for the worked before/after of a tell you cannot fix,
or for the Detection Guidance at the end before deciding prose is AI at all.

Thai-specific patterns live in `patterns-thai.md` (§31–§42: terminology, calque,
anti-fabrication, register, code-switching, AI-leaked closers; §53–§58: grammar slips, headings,
pronouns, dates, apologies, hidden characters) and `patterns-thai-structure.md` (§43–§52).

Every After below uses only facts found in its Before. Where the Before is vague, the After keeps
the gap visible (`<N>`, `[source?]`) instead of filling it.

## CONTENT PATTERNS

### 1. Undue Emphasis on Significance, Legacy, and Broader Trends

**Words to watch:** pivotal moment, a testament to, marks a shift, sets the stage for, plays a vital/key role, underscores the importance of, reflects a broader trend, an enduring legacy, the evolving landscape, a turning point, leaves a lasting mark

**Thai cue:** "ถือเป็นก้าวสำคัญ", "สะท้อนถึงความสำคัญ", "เป็นหลักฐาน", "สร้างคุณค่า", "ส่งเสริม" added at the close of a sentence and carrying no new information → suspect

**Problem:** The text claims that an ordinary change matters to something larger, without saying how. The reader learns nothing from the claim, and it hides the one fact that is there.

**Before:**
> การย้าย database ไป PostgreSQL 16 ถือเป็นก้าวสำคัญ marking a pivotal moment in our platform's evolution and setting the stage for future growth

**After:**
> ย้าย database ไป PostgreSQL 16 แล้ว


### 2. Undue Emphasis on Notability and Media Coverage

**Words to watch:** widely recognized, covered by major outlets, featured across the community, an active social media presence, a growing following, written by a leading expert

**Problem:** The text piles up signs of fame (outlets, follower counts, "widely recognized") instead of the one specific mention that can be checked.

**Before:**
> The library has been widely recognized across the developer community, with coverage in Go Weekly issue 512 and an active social media presence boasting thousands of followers

**After:**
> Go Weekly linked the library in issue 512.


### 3. Superficial Analyses with -ing Endings

**Words to watch:** a trailing clause starting with ensuring, reflecting, highlighting, underscoring, fostering, showcasing, contributing to, paving the way for

**Thai cue:** "ซึ่งสะท้อนถึง...", "เพื่อส่งเสริม...", "ช่วยเสริมสร้าง...", "โดยเน้นย้ำถึง..." trailing a sentence as padding → suspect

**Problem:** A participle clause hangs off the end of a sentence and adds a meaning the facts don't carry. Cut the tail, or turn it into a real fact if there is one.

**Before:**
> The retry wrapper now backs off exponentially, ensuring resilience, reflecting our focus on reliability and fostering trust with downstream teams

**After:**
> The retry wrapper now backs off exponentially.


### 4. Promotional and Advertisement-like Language

**Words to watch:** blazing-fast, battle-tested, production-ready, seamless, supercharge, effortless, game-changing, best-in-class, nestled, in the heart of, vibrant, breathtaking, stunning

**Thai cue:** "งดงามตระการตา", "สวยงามราวภาพวาด", "เป็นที่รู้จักในระดับสากล", "ขึ้นชื่อเรื่อง", "ตั้งอยู่ใจกลาง" → suspect when no real data backs it

**Problem:** The text sells instead of describing. In a README or release note, every adjective of praise needs a number or a source behind it, or it goes.

**Before:**
> Nestled at the heart of your stack, Fluxer is a blazing-fast, battle-tested, production-ready job queue that will supercharge your workflow with breathtaking simplicity

**After:**
> Fluxer is a job queue. [Add a benchmark before "fast" and named production users before "battle-tested".]


### 5. Vague Attributions and Weasel Words

**Words to watch:** experts agree, industry reports suggest, many believe, observers note, studies show (with no study named), some teams have found

**Thai cue:** "ผู้เชี่ยวชาญบางท่านกล่าวว่า", "นักวิจารณ์หลายคนมองว่า", "รายงานระบุ" with no name or source → suspect

**Vague association (newer, 2025+ models):** "linked to", "associated with", "connected to", "tied to" in place of the actual relation ("owns", "calls", "pays for", "wrote"). Thai cue: "มีความเชื่อมโยงกับ", "มีส่วนเกี่ยวข้องกับ" with the relation left unsaid. Fix: state the relation or cut the clause.

**Problem:** A claim leans on an unnamed authority, or says two things are related without saying how. Name the source and the relation, or mark the gap.

**Before:**
> Experts agree that feature flags reduce deployment risk, and industry reports suggest most high-performing teams rely on them. The rollout service is also closely linked to the payments team

**After:**
> Feature flags reduce deployment risk [source?]. The payments team <owns / calls / pays for?> the rollout service.


### 6. Outline-like "Challenges and Future Prospects" Sections

**Words to watch:** despite its strengths ... faces several challenges, despite these challenges, continues to thrive, challenges and opportunities, looking ahead, future outlook

**Thai cue:** "ท่ามกลางความท้าทาย", "อย่างไรก็ตาม...ยังคงเติบโต", "อนาคตของ..." as a wrap-up is usually formula → suspect

**Problem:** A stock "challenges, then hope" section closes the piece whatever the topic. Keep the specific problems; drop the reassurance unless there is a real plan with an owner or date.

**Before:**
> The road for our monorepo has not always been smooth, with slow CI and frequent merge conflicts along the way. Still, thanks to ongoing initiatives, its future looks bright, and it will remain a cornerstone of how we ship for years to come

**After:**
> CI on the monorepo is slow and merge conflicts are frequent. [What is being done about it, by whom, by when?]


## LANGUAGE AND GRAMMAR PATTERNS

### 7. Overused "AI Vocabulary" Words

**High-frequency AI words** (Wikipedia's "Signs of AI writing" list, checked 2026-09, plus siang additions): additionally, align with, bolster, comprehensive, crucial, deep dive, delve, enduring, enhance, foster, garner, highlight (verb), interplay, intricate, key (adjective), landscape (abstract), leverage (verb), meticulous, pivotal, robust (figurative), showcase, stakeholders, tapestry, testament, underscore (verb), vibrant, quietly ("quietly breaks", "quietly powers"), gate/gating (figurative: "gating our growth", "the gate to adoption")

**Thai cue:** "อันที่จริง", "นอกจากนี้", "สำคัญยิ่ง", "ส่งเสริม", "เน้นย้ำ", "ภูมิทัศน์", "จุดเปลี่ยน", "สัมผัสได้", "พยาน", "ขีดเส้นใต้", "อย่างมหาศาล", "อย่างน่าทึ่ง" → suspect when used out of context (a single `อย่างมาก` is fine; stacking is the tell)

**Problem:** These words show up far more often in model output than in human writing, and they tend to come in clusters. One alone proves little; three in a sentence is a tell.

**Guard:** the technical sense is fine. A feature gate, a CI gate, a gated rollout, robust statistics and a robust estimator are terms of art, not AI vocabulary.

**Before:**
> Additionally, this PR delves into the intricate interplay between the cache and the session store, showcasing a robust approach that quietly underscores the pivotal role of invalidation

**After:**
> This PR also touches cache and session-store invalidation.


### 8. Avoidance of "is"/"are" (Copula Avoidance)

**Words to watch:** serves as, stands as, functions as, operates as, acts as, serves to [verb], represents [a], boasts, features, offers [a]

**Thai cue:** "ทำหน้าที่เป็น", "ถือเป็น", "ถือได้ว่าเป็น", "เป็นสัญลักษณ์ของ" instead of a plain "คือ" / "เป็น" → suspect

**Problem:** A longer verb phrase stands in for "is", "has" or a plain verb. The sentence gets heavier and says the same thing.

**Before:**
> The `config/` directory serves as the home of every environment setting. The loader functions as a thin wrapper, and the schema serves to validate input. The CLI boasts three subcommands

**After:**
> `config/` holds every environment setting. The loader is a thin wrapper, and the schema validates input. The CLI has three subcommands.


### 9. Negative Parallelisms and Tailing Negations

**Problem:** The text frames a contrast the reader never asked for, setting the point against something that was never in question: the "not only X but Y" frame, its cousin "it's not just X, it's Y", the same move split over two sentences ("It's not X. It's Y."), or the reversed form "Y rather than X" where X was never on the table. A short negative tag stuck on the end of a sentence ("no guesswork", "zero config") does the same job. Say the positive claim once.

**Keep** a negation that corrects something the reader actually believes. "The timeout is not the cause; the pool is exhausted" is right when the thread has been blaming the timeout.

**Thai cue:** "ไม่ใช่แค่...แต่ยัง...", "ไม่เพียงเท่านั้น แต่...", "ไม่ต้องเดาอีกต่อไป", "ไม่มีอะไรต้องเสียเวลา" as a tail → suspect

**Before (split across sentences):**
> This isn't just a bug fix. It's a rethink of our retry logic. Retries now reuse the request's idempotency key, no duplicate orders

**After:**
> Retries now reuse the request's idempotency key, so a retried request does not create a duplicate order.

**Before (Y rather than X):**
> We store sessions in Redis rather than reinventing the wheel

**After:**
> We store sessions in Redis.

**Before (tailing negation):**
> deploy ผ่าน pipeline เดียว ไม่ต้องจำคำสั่ง

**After:**
> deploy ผ่าน pipeline เดียว คนที่ deploy จึงไม่ต้องจำคำสั่งเอง


### 10. Rule of Three Overuse

**Problem:** Items get grouped in threes because three sounds complete, not because there are three. Often the third item is vague filler. The habit also works at paragraph scale: three sections, three bullets of equal length, three "key takeaways".

**Keep three when there really are three:** a function with three parameters, a release with three fixes, three steps that all happen.

**Thai cue:** "streamline processes, enhance collaboration, and foster alignment" pattern → two is enough, three is too many

**Before:**
> This release brings faster builds, smaller images, and a better developer experience

**After:**
> Builds are faster and images are smaller. [By how much?]


### 11. Elegant Variation (Synonym Cycling)

**Historical (Wikipedia, 2026-09):** common in older models, which cycled synonyms under repetition penalties, and much less frequent in newer ones. Treat as a dating signal for older AI text, not as evidence on its own. The fix still applies as a writing rule.

**Problem:** The same thing gets a new name in each sentence. In technical writing this is worse than dull: the reader assumes four names mean four components.

**Before:**
> The worker pulls jobs from the queue. The worker process then validates each payload, and the job runner writes the result. Finally the queue consumer acks the message (one process, four names)

**After:**
> The worker pulls a job from the queue, validates the payload, writes the result and acks the message.


### 12. False Ranges

**Weak (Wikipedia, revision 2026-11-08):** the current "Signs of AI writing" page no longer lists false ranges. Treat one as weak evidence, never a tell on its own; that does not make it a sign of human writing either. The fix still applies as a writing rule.

**Problem:** "From X to Y" where X and Y are not two ends of one scale. It sounds broad and lists two unrelated things.

**Thai cue:** "ตั้งแต่...จนถึง...", "จาก...สู่..." where the two ends are not on one scale → suspect

**Before:**
> This guide takes you from installing the CLI to mastering the art of distributed tracing, from your first commit to the philosophy of observability

**After:**
> This guide covers installing the CLI, the first commit and distributed tracing.


### 13. Passive Voice and Subjectless Fragments

**Problem:** The text hides who does what ("logs are rotated", "no setup required"). Name the actor when it helps the reader know what to run or whom to ask.

**Before:**
> เมื่อรัน `app start` ค่า config ถูกโหลดโดยอัตโนมัติ ไม่ต้องตั้งค่าเพิ่ม

**After:**
> `app start` โหลดค่า config ให้เอง คุณไม่ต้องตั้งค่าอะไรเพิ่ม


## STYLE PATTERNS

### 14. Em Dashes (and En Dashes): Cut Them

**Rule:** In Thai prose, em dash has no native typography convention: strip unconditionally, no exceptions (see `references.md` typography rules). In English/mixed text the zero-dash rule is house style, not detection: Wikipedia now files em-dash overuse under historical indicators (2022 to September 2026), and siang cuts dashes because periods and commas read cleaner and Thai prose does not use them. Check first whether the user gave a writing sample that uses em dashes on purpose, and if so keep them there per the Voice section. A real author's habit outranks this rule. Otherwise the final rewrite holds none: this is a hard limit, not a hint to go easy on them. Fix each one with the first option that fits: end the sentence and start another, a comma for a short aside, a colon when an explanation follows, parentheses for a real aside, or rebuild the sentence. The same goes for a spaced em dash (` — `) and a double hyphen (` -- `) doing that job.

**En-dash exemption:** number ranges (`40–60%`, `§31–32`, `2–5 minutes`) are fine. That's an en dash (`–`) doing its actual job, not an AI tell. The rule is about *em dashes used for asides* and *en dashes used as em dashes*. The em dash (`—`) is what AI overuses.

**Before (AI overuse):**
> The cache layer — added last sprint — cuts p95 latency in half — at least on the read path.

**After:**
> The cache layer, added last sprint, cuts p95 latency in half, at least on the read path.

**Before (AI overuse in Thai):**
> hotfix นี้ — merge เมื่อคืน — แก้ timeout ฝั่ง checkout -- แต่ยังไม่แก้ฝั่ง refund

**After:**
> hotfix ที่ merge เมื่อคืนแก้ timeout ฝั่ง checkout แต่ยังไม่แก้ฝั่ง refund

In Thai the replacement is a space or parentheses (§45), not a period.

Last check before you hand the rewrite over: search it for em dashes (`—`). One hit means it is not finished, unless that dash came from the user's own English writing sample. En-dash number ranges are exempt.


### 15. Overuse of Boldface

**Problem:** Bold lands on every noun that seems important, so nothing stands out. Keep bold for the one thing a skimming reader must not miss, if any.

**Before:**
> Set **`DATABASE_URL`** and **`REDIS_URL`** before running **migrations**. The **worker** reads **both** at startup

**After:**
> Set `DATABASE_URL` and `REDIS_URL` before running migrations. The worker reads both at startup.


### 16. Inline-Header Vertical Lists

**Problem:** Every bullet starts with a bolded word and a colon, then a sentence that says that word again. Three short facts become a padded list.

**Before:**
> - **Logging:** Logging has been improved with structured JSON output
> - **Errors:** Error handling has been enhanced with clearer messages
> - **Config:** Configuration has been simplified with fewer required keys

**After:**
> Logs are now structured JSON, error messages are clearer, and fewer config keys are required.


### 17. Title Case in Headings

**Problem:** Every main word in a heading is capitalized. Most dev docs and style guides use sentence case.

**Before:**
> ## How To Configure Rate Limiting For Your API

**After:**
> ## How to configure rate limiting for your API


### 18. Emojis

**Problem:** Emojis decorate headings and bullets in text that is not a chat message.

**Before:**
> 🚀 **Deploy:** v2.3 ships Thursday
> 🐛 **Fixes:** 4 bugs closed
> ✅ **Next:** update the runbook

**After:**
> v2.3 ships Thursday with 4 bug fixes. Next: update the runbook.


### 19. Curly Quotation Marks

**Problem:** Typographic quotes (“...”) show up in text, or next to code, that otherwise uses plain straight quotes ("...").

**Before:**
> Set the `Cache-Control` header to “no-store” and redeploy

**After:**
> Set the `Cache-Control` header to "no-store" and redeploy


## COMMUNICATION PATTERNS

### 20. Collaborative Communication Artifacts

**Words to watch:** I hope this helps, Of course!, Certainly!, Sure, here's..., Would you like me to..., let me know if..., feel free to

**Problem:** Lines meant for the chat with the model get pasted into the document itself.

**Before:**
> Sure! Below is the revised install section for the README. I hope this helps, and feel free to ask if you want a troubleshooting part as well.
>
> ## Install
>
> Run `npm install fluxer`.

**After:**
> ## Install
>
> Run `npm install fluxer`.


### 21. Knowledge-Cutoff Disclaimers and Speculative Gap-Filling

**Words to watch:** as of my last update, based on the information available, details are limited/scarce, not readily documented, it appears to have been, likely [was built / grew up], it is believed that, suggesting that

**Thai cue:** "ณ ขณะนี้", "ตามข้อมูลที่มีอยู่", "ยังไม่มีข้อมูลที่เปิดเผย", "เชื่อว่า", "น่าจะเติบโตในครอบครัวชนชั้นกลาง" → suspect

**Problem:** Two related tells. (a) A note about the model's own knowledge date stays in the text. (b) When no source turns up, the text says so and then guesses anyway, and the guess reads like a fact. Say what is unknown, or cut the sentence.

**Before (cutoff disclaimer):**
> As of my last update, the library's latest version appears to be 4.x, though details may have changed

**After:**
> Latest version: <check the registry>.

**Before (speculative gap-fill):**
> Detailed documentation of the legacy billing service is not readily available, suggesting it was likely built quickly by a small team and has been maintained with minimal oversight

**After:**
> We found no documentation for the legacy billing service.


### 22. Sycophantic/Servile Tone

**Problem:** Praise for the question or the asker comes before the answer and adds nothing to it.

**Thai cue:** "คำถามดีมากค่ะ", "ถูกต้องเลยครับ", "เป็นประเด็นที่ดีมาก" in real writing → suspect (AI assistant leak)

**Before:**
> What a sharp observation, and you're completely right: the retry loop never stops. Brilliant thinking on the backoff as well

**After:**
> Agreed, the retry loop never stops. You're right about the backoff as well.


## FILLER AND HEDGING

### 23. Filler Phrases

**Before → After:**
- "In order to run the tests" → "To run the tests"
- "Due to the fact that the cache is cold" → "Because the cache is cold"
- "At the present moment we do not support Windows" → "We don't currently support Windows"
- "In the event that the job fails" → "If the job fails"
- "The service has the capability to retry" → "The service can retry"
- "It is worth noting that the endpoint is deprecated" → "The endpoint is deprecated"

**Thai filler → fix:**
- "เพื่อที่จะทำการรัน test" → "เพื่อรัน test"
- "เนื่องจากข้อเท็จจริงที่ว่า cache ยังว่าง" → "เพราะ cache ยังว่าง"
- "ณ ปัจจุบันขณะนี้ยังไม่รองรับ Windows" → "ตอนนี้ยังไม่รองรับ Windows"
- "ในกรณีที่ job เกิดความล้มเหลว" → "ถ้า job fail"
- "service มีความสามารถในการ retry" → "service retry ได้"
- "สิ่งที่ควรทราบคือ endpoint นี้ deprecated แล้ว" → "endpoint นี้ deprecated แล้ว"


### 24. Excessive Hedging

**Problem:** One claim carries several hedges. Keep one, sized to how sure you really are. This is the rule for stacked hedges in every language; §32.1 and §32.4 point here.

**Not hedges:** a scope statement ("on Linux only", `เฉพาะบน staging`), a warning or safety notice, and a real correction. Leave them in.

**Thai cue:** "อาจจะเป็นไปได้ว่าน่าจะอาจจะ..." → suspect (one hedge is enough)

**Before:**
> It might perhaps be possible that the flaky test could potentially be related to the timezone setup

**After:**
> The flaky test may be related to the timezone setup.


### 25. Generic Positive Conclusions

**Problem:** The piece ends on upbeat words about the future instead of the next real step. Keep the step if there is one; otherwise end on the last fact.

**Before:**
> This release opens a bright new chapter for the project, and the best is yet to come as we keep building something developers will love. Next up is Windows support

**After:**
> Next up is Windows support.


### 26. Hyphenated Word Pair Overuse

**Words to watch:** a run of coined compounds in one phrase: developer-obsessed, insight-rich, friction-free, outcome-focused, scale-ready, future-forward

**Problem:** The tell is a stack of made-up hyphen compounds, each standing in for a claim the text does not back up. A single compound is not the tell, and dictionary-standard compounds (third-party, built-in, read-only, real-time, end-to-end, open-source) are correct: keep their hyphen wherever the dictionary or the project's style guide puts it. Don't add or strip hyphens by sentence position; fix the stack by cutting the coined pairs or replacing them with the facts they stand for.

**Before:**
> A developer-obsessed, insight-rich, friction-free dashboard for outcome-focused teams. Ships with built-in auth and third-party SSO.

**After:**
> A dashboard for <which teams?>. Ships with built-in auth and third-party SSO.


### 27. Persuasive Authority Tropes

**Phrases to watch:** at its core, fundamentally, what really matters, the heart of the matter, the deeper issue, make no mistake, the truth is, in reality

**Thai cue:** "คำถามที่แท้จริงคือ", "โดยแท้จริง", "ในแก่นสำคัญ", "ประเด็นที่ลึกซึ้งกว่านั้น" → suspect

**Problem:** A framing phrase promises a deeper point and then states an ordinary one. Drop the framing and make the point.

**Before:**
> Make no mistake, the real story here is connection pooling. The deeper issue, in reality, is that every request opens its own connection

**After:**
> Every request opens its own connection; the fix is connection pooling.


### 28. Signposting and Announcements

**Phrases to watch:** Let's dive in, let's break this down, here's what you need to know, now let's look at, without further ado, in this section we will; stand-alone candor openers such as "Honestly?", "Here's the thing:", "Look,", "Real talk:", "Let's be honest:"

**Problem:** The text announces what it is about to say, or stages a moment of frankness, before saying it. Cut the run-up and start with the point. "Honestly" or "look" inside an ordinary sentence ("I honestly don't know why it retried twice") is fine; the tell is the opener that stands on its own.

**Thai cue:** "เรามาเจาะลึกกัน", "สิ่งที่คุณต้องรู้คือ", stand-alone "พูดตรงๆ นะ", "เอาจริงๆ?" before the point → suspect

**Before:**
> Let's break down how the rate limiter works. Without further ado: each API key gets its own token bucket

**After:**
> Each API key gets its own token bucket in the rate limiter.

**Before (candor opener):**
> Here's the thing: the staging DB is a week behind prod

**After:**
> The staging DB is a week behind prod.


### 29. Fragmented Headers

**Signs to watch:** a one-line paragraph under a heading that says the heading again before any content starts; a `---` rule between every pair of sections; skipped heading levels, or more than one level-1 heading in a document.

**Problem:** A warm-up line under the heading repeats the heading and delays the content.

**Before:**
> ## Rollback
>
> Rollbacks are important.
>
> Run `deploy rollback <release>` to restore the previous release.

**After:**
> ## Rollback
>
> Run `deploy rollback <release>` to restore the previous release.


### 30. Diff-Anchored Writing

**Problem:** Docs and comments describe the last change instead of the current state, or describe the writer's own process and the page layout instead of the content. Unless the document is version-scoped by nature (changelog, release notes, migration guide), it should make sense to someone who never saw the previous version. Two related forms: narrating your method ("we collected these by...", "to be fair, we...") when only the result matters, and explaining a layout that is already in front of the reader ("the table below is sorted with...", "the left column shows..."). Keep a method fact the reader needs to trust the numbers, stated once and plainly.

**Before (diff-anchored):**
> Rewrote this helper: it used to loop over users one at a time and now loads them all in a single batched query

**After:**
> This helper loads all users in a single batched query.

**Before (method and layout narration):**
> To be fair to every library, we ran each benchmark five times and took the median. The table below is sorted with the fastest library at the top, and the columns go from cold start to warm start

**After:**
> Median of five runs per benchmark.


## READER AND ARGUMENT PATTERNS

### 59. Re-explaining What the Reader Already Knows

**Phrases to watch:** as you know, for context, to recap, a quick refresher, let me start with some background, as mentioned earlier (in a short reply)

**Thai cue:** "อย่างที่ทราบกันดี", "ขอเล่าที่มาก่อน", "เพื่อให้เห็นภาพ" opening a short reply → suspect. The same tell in a support reply is echo-back: `รับทราบค่ะ คุณลูกค้าแจ้งว่า... ใช่ไหมคะ` restates the customer's own message before the answer (cut it; keep an order or ticket number inside the answer).

**Rule:** In a reply, lead with the decision or answer and the one fact the reader does not have yet. The full diagnosis goes in the ticket, the PR or the doc, and the reply links to it.

**Why AI does it:** a model assumes a reader who knows nothing, since that guess is safe in most settings. Someone answering in a thread already has the background, so a recap pushes the answer to the end.

**Before (reply to "can we ship Friday?"):**
> As you know, the release depends on the payments migration, which moves card tokens from the old vault to the new one. The migration has three phases: export, re-encrypt and import. Export and re-encrypt finished Tuesday. Import failed last night on 212 tokens with an expired key. So we can't ship Friday; we need until Monday to rotate the key and re-run the import.

**After:**
> Not Friday, Monday. Import failed on 212 tokens with an expired key; we need to rotate the key and re-run it. <link to ticket>


### 60. Punchline Closers and Fragment Runs

**Phrases to watch:** a paragraph of one line that only repeats the point before it ("That's the win.", "That changes everything.", "Big difference."); a row of punchy fragments ("Faster. Simpler. Cheaper."); a matching closer at the end of each section

**Thai cue:** "นี่แหละคือจุดเปลี่ยน", "จบ.", "ง่ายๆ แค่นั้น" as a paragraph of its own → suspect

**Rule:** Merge the closer into the claim it repeats, or cut it. A row of fragments becomes one sentence, keeping only the fragments the text supports. A short sentence is fine when it adds a new fact.

**Why AI does it:** the model copies the rhythm of marketing copy and social posts, where a lone short line makes the reader stop for effect. In technical writing the pause adds nothing the reader can use.

**Before:**
> We moved session storage from Postgres to Redis. p99 login latency dropped from 800 ms to 90 ms.
>
> That's the win.
>
> Faster. Simpler. Cheaper.

**After:**
> We moved session storage from Postgres to Redis, and p99 login latency dropped from 800 ms to 90 ms.


### 61. Arguing with No One

**Phrases to watch:** some might argue, you might be thinking, and no, this isn't..., critics will say, ... was never on the table, before you ask

**Thai cue:** "บางคนอาจแย้งว่า", "อาจมีคนสงสัยว่า", "ก่อนจะมีคนถาม" with no one named → suspect

**Rule:** Cut defenses against objections nobody raised and rejections of options nobody proposed. Keep an objection only when it is attributed (a reviewer, a thread, an earlier ADR) and the text answers it. An ADR or design doc may list the real options it considered and rejected; cut only the rejection of an option no reader would weigh.

**Why AI does it:** the model expects pushback that is not in the context, or keeps a rebuttal from an earlier draft after the thing it rebutted is gone.

**Before (ADR):**
> We chose SQLite for the local cache. Some might argue we should run a full Postgres instance, but that would be overkill. And no, this is not premature optimization. Rewriting the cache in Rust was never on the table either.

**After:**
> We chose SQLite for the local cache.


## DETECTION GUIDANCE

### Not a tell: false positives to leave alone

Someone writing carefully without any AI can still trip several patterns above. Check before you rewrite that you are not flattening good prose. None of these is a reliable sign by itself:

- **Clean grammar and a steady style.** Plenty of writers are trained or edited. Polish is not proof.
- **A mix of casual and formal register.** This is common in engineers, younger writers and people whose prose just runs that way. **For Thai: Thai writers code-switch Thai-English by habit; it is normal, not always an AI tell**
- **Dry, plain prose.** AI text has particular tells. Dry writing without them is just dry.
- **Formal or academic words.** §7 lists the particular words models overuse; it is not a ban on long words. Leave "ostensibly" or "constituent" alone. **For Thai: formal words in a formal context are not always an AI tell**
- **A greeting or sign-off on a comment or email.** People wrote those long before chatbots.
- **One transition word.** "However" or "moreover" counts only when they pile up.
- **Curly quotes by themselves.** Most editors and word processors curl quotes automatically. Count them only next to other tells.
- **Em dashes by themselves.** Many good writers use them a lot. They count only alongside a formulaic, salesy rhythm. **For Thai: an em dash hints at the pattern but is not proof when it appears once in a document**
- **Missing citations.** Most writing has none.
- **Tidy, complex formatting.** Templates and editors produce that on their own.

When unsure, look for several tells together, not one. A lone em dash says nothing. Em dashes, triads, "seamless", "pivotal" and a closing "Conclusion" heading together say a lot.


### Signs a person wrote it (keep these)

These point to a real writer. When you see them, edit less, because heavy rewriting removes exactly what makes the text sound like a person:

- **Odd, specific detail that is hard to make up.** An exact error string, a hostname, the name of the teammate who found the bug. Models smooth details away; people keep them. **For Thai: a ticket link, a log timestamp, a real teammate's name, "เมื่อวานคุยกับพี่แจ็ค"**
- **Doubt that stays open.** "Mostly fine, but something about the retry path still bugs me." Models prefer a clean verdict.
- **References tied to a time and a group.** In-jokes, slang or tool names that belong to one team or one year. Models trail behind.
- **Choices the writer can explain.** A cut or a word the author can justify is a strong sign of a person.
- **Uneven sentence length.** People mix short and long. Model text drifts to a steady middle length. **For Thai: alternate "ผ่าน" (short) with "ทดสอบบน staging แล้ว เคส burst ผ่าน ส่วน moto drop ยังไม่ผ่าน" (long)**
- **Real asides and self-corrections.** "(I first wrote 'always' here, but it was twice.)" Models rarely break their own flow like that.
- **Anything dated before ChatGPT's launch (30 November 2022).** Text that old is almost never AI-written.
