# Register and language gate

Read at step 1 of `SKILL.md`: pick genre and language before scanning.

## §0. Register and language gate

Pick genre **and** language; they are orthogonal. Match what the reader actually reads.

| # | Genre | Example | English ~% | Particle default | Apply |
|---|-------|---------|-----------|------------------|-------|
| **A** | Chat / LINE | chat, comment | 10–25% (TH) / 100% (EN) | 555 / ค่ะ / ครับ by gender / none (EN) | §34, §38 |
| **B** | Standup / PR / commit | daily standup, PR desc | 40–60% (TH) / 100% (EN) | no particle on terse items / none (EN) | §35, §38 |
| **C** | UI / error / notification | payment decline, 404 | 20–35% (TH) / 100% (EN) | at most one ค่ะ/ครับ / none (EN) | §36, §36.1, §38 |
| **D** | Prose / blog / strategy / ADR | article, brief | 30–50% (TH) / 100% (EN) | no bare particle / none (EN) | §37, §38 |

A person replying to a customer in chat (support, incident thread) is C in content but a live conversation: most sentences end in `ค่ะ`/`ครับ` (or a softer `นะคะ`/`นะครับ`), because a bare sentence reads curt to a customer; apology sized to the harm (§57). Ordinary politeness (`รบกวน`, `ขอ`, `นะ`) is never a tell in itself (§40 guard). High cognitive load (hotfix, incident, alert) is written monolingual. An EN-only audience gets monolingual EN. Detail: §34–§38 in `patterns-thai.md`.

**Terminology:** keep English by default in internal dev writing (commit, merge, PR, staging, develop, production); user-facing text translates or transliterates per the Royal Society's transliteration rules; Thai is never romanized internally. Decision tree: §31 in `patterns-thai.md`.

**Typography:** Thai has no inter-word spaces (a space is a phrase or sentence break); one space around English when it helps, glued to identifiers and numbers is fine (`PR #82`, `v1.11.37`); Arabic numerals (`2026`, `77%`), never Thai numerals in dev/tech text; user-facing dates use the BE year and `01.00 น.` (§56); strip zero-width spaces and keep one `ๆ` spacing form per piece (§58).

**Calques to replace:** `ถือไว้` → `ยังไม่ปล่อยขึ้น prod / พักไว้`; `ดัน` → `merge / นำขึ้น prod`; `ระบบล้ม` → `ระบบล่ม / down` (§31 has worked before/after). An unverified completion claim (`ทดสอบบน staging ผ่าน`) is a fabrication-boundary case, not a calque: §32.
