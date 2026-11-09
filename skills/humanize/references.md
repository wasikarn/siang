# References (extends SKILL.md)

> Sources + glossary for the Thai-specific patterns (§31-§42 and §53-§58 in `patterns-thai.md`, §43-§52 in `patterns-thai-structure.md`) and the universal patterns (§1-§30, §59-§61). No need to load this file to apply a pattern; load it when you must verify a transliteration or cite a source.

---

## Reference

This skill extends [Wikipedia:Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing), maintained by WikiProject AI Cleanup, by way of [blader/humanizer](https://github.com/blader/humanizer), with 28 Thai-specific top-level patterns (§31-§42 and §53-§58 in `patterns-thai.md`: terminology & calque, anti-fabrication, connectives, register matrix, code-switching tells, AI-leaked closers, grammar slips, headings, pronouns, dates, apologies, hidden characters; §43-§52 in `patterns-thai-structure.md`: sentence and paragraph structure) and a Thai-register foundation (§0).

### Sources adapted (MIT)

- **[blader/humanizer](https://github.com/blader/humanizer)**, MIT, Copyright (c) 2025 Siqi Chen. The universal catalog (`patterns-universal.md` §1–§30 and `cue-sheet.md`): pattern titles, order and much of the rule text came from its v2.7.0, reached method-harness in June 2026, and was not credited until 2026-11-09. §59–§61 (re-explaining, one-line closers, arguing with no one) and the step-6 re-scan and dropped-fact check in `SKILL.md` are paraphrased from its v3.1.0. Its examples and rule wording, copied until then, were replaced with siang's own on 2026-11-09.
- **[chakrit/kien-thai](https://github.com/chakrit/kien-thai)**, MIT, Copyright (c) 2026 Chakrit Wichian. The seven discourse frames and supporting structure rules (`patterns-thai-structure.md` §43–§52), surface grammar slips (§53), headings (§54), and the additions marked "Adapted from chakrit/kien-thai" in §31, §32.4, §33, §37, §38, §39.4, §40, §46, §47, §55, §56, §58 and cue rows #7, #25, #27. Rules are paraphrased. A 2026-11-09 re-read found several examples that were the source's own example with one noun swapped; those were rewritten with a different sentence shape. kien-thai's exemplar passages from third-party writers were never copied. The 2026-11-09 corrections to §32.8 (`ท่าน` is formal, not royal) and §38 (`ถูก` vs `โดน`) also follow it.
- **[Boom-Vitt/claude-thai-skills](https://github.com/Boom-Vitt/claude-thai-skills)**, MIT, Copyright (c) 2026 Vittawat (Boom-Vitt). Pronouns (§55), dates and times (§56), apology and promises (§57), hidden characters (§58), and the additions marked "Adapted from Boom-Vitt/claude-thai-skills" in §31, §38, §39.1, §40 and cue row #4. Drawn from its `thai-translate`, `thai-customer-service`, `thai-social-caption`, `thai-text-processing`, `thai-date-format`, `thai-resume` and `thai-id-validate` skills. Rules are paraphrased; the dates and one pronoun pair that matched its examples were replaced on 2026-11-09. Its customer-service guidance also set the particle density for human customer replies (`SKILL.md` §0, §40 table).

Full license texts: `THIRD_PARTY_NOTICES.md` at the plugin root.

### Cited, not copied

- thaiall.com IT dictionary (https://www.thaiall.com/itdictionary/): its large term list re-hosts the Royal Society's computer and IT terms (ภาษาไทย ภาษาสื่อ ฉบับราชบัณฑิตยสภา, 2016, pp. 421-460). No license is stated, so nothing was copied; it was used only to check the Thai spellings named in §31, and the Royal Society links below are the primary source.
- Wikipedia text is CC BY-SA 4.0. The universal catalog follows the page's structure; example passages quoted from it were replaced on 2026-11-09, so no CC BY-SA text remains here.

### Thai-specific references
- Royal Society of Thailand (`ราชบัณฑิตยสภา`) transliteration: https://transliteration.orst.go.th/search
- Royal Society of Thailand (`ราชบัณฑิตยสภา`) terminology: https://royalsociety.go.th/thai-translation-terminology/
- Mozilla Thai Style Guide: https://mozilla-l10n.github.io/styleguides/th/  *(explicit "3 translation styles" framework: translate / transliterate / leave untranslated)*
- Microsoft Thai Style Guide (UI string + terminology, TBX)
- Google translation style: https://developers.google.com/style/translation
- W3C Thai Layout: https://www.w3.org/TR/thai-gap/ · https://www.w3.org/TR/thai-lreq/
- Microsoft Thai typography: https://learn.microsoft.com/en-us/typography/script-development/thai
- Thaweephol, P. & Saisuwan, P. (2021). Attitudes towards Thai-English code-switching among Thai speakers in Generation Y. *Journal of Language and Culture* 40(2), 53-78. https://so03.tci-thaijo.org/index.php/JLC/article/view/257581 (ChulaSEAL summary of the follow-on thesis, 2024: https://www.arts.chula.ac.th/chulaseal/2024/05/31/do-thai-people-really-consider-code-switching-inappropriate-and-unnatural-an-insight-into-thai-peoples-attitude-toward-code-switching/)
- Umpornpun, A. & Mongkolhutthi, P. (2022). Conversational code-switching among Thai teenage multilingual gamers: a sequential analysis. *Theory and Practice in Language Studies* 12(11). https://tpls.academypublication.com/index.php/tpls/article/view/5030 (closest published setting to "dev chat")
- Conventional Commits Thai v1.0.0: https://www.conventionalcommits.org/th/v1.0.0/  *(keeps `fix:`/`feat:` in English — tooling requirement)*

### Universal references
- Wikipedia "Signs of AI writing" (basis for §1-§30)

### Thai NLP / Code-switching References (v2.2 additions)

- **Lowphansirikul et al. (2021)** "WangchanBERTa" — Thai RoBERTa pretrained on ~78GB Thai monolingual corpus; basis for §38 code-switching tells *(arXiv:2101.09635 — 2021, arXiv preprint cs.CL, not EMNLP)*
- **Phatthiyaphaibun et al. (2023)** "PyThaiNLP: Thai Natural Language Processing in Python" — NLP-OSS 2023 workshop (co-located with EMNLP 2023, Singapore), pp. 25-36, ACL Anthology [2023.nlposs-1.4](https://aclanthology.org/2023.nlposs-1.4/), DOI 10.18653/v1/2023.nlposs-1.4, arXiv:2312.04649. Thai NLP toolkit with mixed-script tokenizers (newmm / attacut / nlpo3); used as §38 reference for tokenization-aware code-switching norms. *(Corrected 2026-07-02: the prior "PyThaiNLP 4.0 (2024)" attribution was fabricated — v4.0 was a software release, GitHub tag v4.0.0, April 2023, never a paper.)*

### Verification Tools (v2.2 additions)

- **WebFetch / WebSearch** — verify URL claim
- **context7 MCP** — verify library API
- **Glob / Grep** — verify file path
- **Google Scholar / arxiv** — verify paper claim
- **Calendar** — verify date precision

> **No empirical answer yet** (validate with your own audience): the right share of English in a Thai error message; each team's real code-switching pattern

---

## Default Thai+Tech Glossary

Canonical table lives in `patterns-thai.md` §31 — load it for the current, complete glossary. Sample rows only below, to show the shape; do not treat this file as authoritative for glossary lookups. Project-specific terms (ANPR, dwell, front-facing, PDPA, traffic-campaign) go in a project glossary, not here.

| Term | Internal | User-facing |
|----|----------|-------------|
| staging / develop / production | คงอังกฤษ | "ระบบทดสอบ" / (none) / "ระบบจริง" + อธิบาย |
| merge | merge | รวมโค้ด |
| declined (bank/payment) | declined (เก็บไว้ใน log เท่านั้น) | ถูกปฏิเสธ |

### Calques to avoid (selected; full list in §0 + §31)

| ❌ Calque | ✅ Better |
|-----------|-----------|
| ถือไว้ (HELD) | ยังไม่ปล่อย |
| ดัน (push) | merge |
| ระบบล้ม (down) | ระบบล่ม |
| เซสชั่น (non-standard spelling) | เซสชัน |

### Typography rules (selected; full list in §0 + §14)
- Tone and silent marks: Royal Society transliterations of English words carry no tone mark (`เซสชัน`, not `เซสชั่น`); the silent mark `์` (การันต์) appears only where a silent source letter is kept, as in `ซอฟต์แวร์`, `ฟิล์ม`.
- Hyphen: use `-` (ASCII U+002D), not en-dash `–`, in compounds (low priority, font-dependent)
- Em dash `—`: never in Thai prose (see §14)
- En dash `–`: number ranges only (40–60%, §31–32, `2–5 นาที`)
