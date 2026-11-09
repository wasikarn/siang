# Pattern cue-sheet (§1–§30 and §59–§61)

Scan for these 33 universal tells (all languages). Thai-only tells: §31–§42 and §53–§58 in `patterns-thai.md`, §43–§52 (sentence structure) in `patterns-thai-structure.md`. Worked before/after per pattern and the false-positive list: `patterns-universal.md`.

| # | Pattern | Cue (EN / TH) | Fix |
|---|---------|---------------|-----|
| 1 | Significance/legacy puffery | testament, pivotal moment, evolving landscape / ถือเป็นก้าวสำคัญ, สะท้อนถึงความสำคัญ | Cut the importance claim; state the fact |
| 2 | Notability / media name-drops | widely recognized, active social media presence | Keep only sourced, specific claims |
| 3 | -ing pseudo-depth tails | highlighting, ensuring, reflecting, fostering / ซึ่งสะท้อนถึง, เพื่อส่งเสริม | Delete the trailing clause or make it a real fact |
| 4 | Promo / ad language | vibrant, nestled, in the heart of, breathtaking, production-ready, battle-tested, supercharge your workflow / งดงามตระการตา, ตั้งอยู่ใจกลาง, พร้อมใช้งานระดับ production, ผ่านการพิสูจน์แล้ว | Neutral tone; concrete detail |
| 5 | Vague attribution / weasel / vague association | experts agree, industry reports suggest; linked to, associated with, connected to / ผู้เชี่ยวชาญบางท่าน, รายงานระบุ, มีความเชื่อมโยงกับ | Name the source, or state the actual relation, or cut |
| 6 | "Challenges & future" formula | despite these challenges, continues to thrive, future outlook / ท่ามกลางความท้าทาย, อนาคตของ | Keep the specific problems; drop the reassurance |
| 7 | AI-vocab words | delve, crucial, tapestry, underscore, intricate, landscape, robust, deep dive, meticulous, quietly, figurative gate/gating, leverage, comprehensive, stakeholders / อันที่จริง, นอกจากนี้, สำคัญยิ่ง, ส่งเสริม, เน้นย้ำ, ภูมิทัศน์, จุดเปลี่ยน, สัมผัสได้, พยาน, ขีดเส้นใต้, อย่างมหาศาล, อย่างน่าทึ่ง (a single `อย่างมาก` is fine; stacking is the tell) | Plain synonyms; technical senses (feature gate, CI gate, robust statistics) stay |
| 8 | Copula avoidance | serves as, stands as, functions as, operates as, serves to, boasts, features / ทำหน้าที่เป็น, ถือเป็น | Use is/are/has or the plain verb · คือ/เป็น |
| 9 | Negative parallelism / tailing negation | not only…but, it's not just…it's, "It's not X. It's Y.", Y rather than X / ไม่ใช่แค่…แต่ยัง, ไม่ต้องเดา | One real positive clause; keep a negation that corrects what the reader actually believes |
| 10 | Rule of three | forced triads "X, Y, and Z"; three equal sections or takeaways / สองพอ สามเกิน | Two if there are two; cut the forced third; keep three when there really are three |
| 11 | Elegant variation (historical) | worker→worker process→job runner→queue consumer for one process; common in older models, much rarer in newer ones | Reuse the same noun; weak evidence on its own |
| 12 | False ranges (weak) | "from X to Y" off-scale / ตั้งแต่…จนถึง, จาก…สู่; no longer on Wikipedia's list | List the items plainly; weak evidence on its own |
| 13 | Passive / subjectless | "logs are rotated, no setup required" | Name the actor; active voice |
| 14 | Em dashes | `—` used for asides | Period / comma / colon / parens (en-dash ranges `40–60%` are fine) |
| 15 | Boldface overuse | mechanical `**bold**` | Drop decorative bold |
| 16 | Inline-header lists | `- **X:**` that restates X | Prose or plain bullets |
| 17 | Title case headings | `## How To Configure Rate Limiting` | Sentence case |
| 18 | Emojis | 🚀 💡 ✅ on headings/bullets | Remove |
| 19 | Curly quotes | `“ ”` | Straight quotes `" "` |
| 20 | Chat artifacts | I hope this helps, Certainly!, let me know | Cut the assistant talk |
| 21 | Cutoff disclaimers / gap-fill | as of my last update, details are limited, likely was built / ณ ขณะนี้, `น่าจะ` that fills a gap with a guess, เชื่อว่า | Say what's unknown or cut; don't guess. One hedged estimate on partial data is fine (§32.4) |
| 22 | Sycophancy | Great catch!, You're absolutely right / คำถามดีมากค่ะ | Drop |
| 23 | Filler phrases | in order to, due to the fact that, in the event that / เนื่องจากข้อเท็จจริงที่ว่า, ณ ปัจจุบันขณะนี้ | Shorten |
| 24 | Excessive hedging | might perhaps possibly / อาจจะเป็นไปได้ว่าน่าจะ | One hedge max |
| 25 | Generic positive conclusion | future looks bright, journey toward excellence / โดยสรุปแล้ว, กล่าวโดยสรุป | Concrete next fact, or cut |
| 26 | Hyphenated-pair overuse | a stack of coined pairs: insight-rich, friction-free, developer-obsessed | Cut the coined pairs or state their facts; dictionary compounds (third-party, built-in) keep the hyphen |
| 27 | Authority tropes | at its core, fundamentally, what really matters / คำถามที่แท้จริงคือ, ในแก่นสำคัญ, เป็นที่ทราบกันดีว่า, ปฏิเสธไม่ได้ว่า | Make the actual point |
| 28 | Signposting / candor openers | let's dive in, here's what you need to know; stand-alone "Honestly?", "Here's the thing:", "Look," / พูดตรงๆ นะ | Just say it; an inline "honestly" is fine |
| 29 | Fragmented headers / thematic breaks | heading + one-line restating it; `---` between every section | Delete the warm-up line and the rules |
| 30 | Diff-anchored writing / method narration | "this was added to replace…"; "we ran each benchmark…"; "the table below is sorted…" | Describe the thing as it is; keep a needed method fact in one plain line |
| 59 | Re-explaining what the reader already knows | as you know, for context, to recap (in a reply) / อย่างที่ทราบกันดี, ขอเล่าที่มาก่อน | Lead with the decision and the one new fact; the diagnosis goes in the ticket |
| 60 | Punchline closers and fragment runs | "That's the win.", "Faster. Simpler. Cheaper." / นี่แหละคือจุดเปลี่ยน, จบ. | Merge into one claim or cut |
| 61 | Arguing with no one | some might argue, and no, this isn't…, was never on the table / บางคนอาจแย้งว่า | Cut; keep only an objection that is attributed and answered |
