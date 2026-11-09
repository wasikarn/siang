# siang (เสียง)

**Claude Code skills for dev and tech writing that reads like a person wrote it.**

[ภาษาไทย](README.th.md)

> Text from a model has a smell.

A standup that opens with "I'm excited to share", a PR description with three bullets of equal
length, a Thai notice that ends every sentence in ครับ and leans on "ซึ่ง" and "โดย". Readers
notice within a line, and then they stop trusting the rest.

siang is a Claude Code plugin that removes that smell in English, Thai, and Thai-English
code-switching, and covers the nearby jobs: writing a doc a reader can follow, auditing a record
against its standard, and keeping your own voice. เสียง means "voice".

## Who it's for

- Developers who let a model draft chat, standups, PR and commit text, UI strings, ADRs or
  READMEs, in English or Thai.
- Teams whose Thai output from a model reads like a translation.
- Anyone who has pasted a draft and thought "this sounds like AI".

## Install

```bash
claude plugin marketplace add wasikarn/siang
claude plugin install siang@siang
```

## The five skills

| Skill | Use it when | What it does |
|---|---|---|
| `siang:humanize` | a draft reads like a model wrote it | names every AI tell against a cue sheet, rewrites, then re-reads for what is left |
| `siang:technical-writing` | you need a how-to, tutorial, reference page, runbook or README | picks one Diátaxis quadrant per doc, takes facts from the code and from commands it runs, marks anything unchecked `TODO: verify` |
| `siang:document-review` | a record must match a standard (SOP, runbook, policy, spec) | lists the claims, checks each for precision, logic, traceability and compliance, returns a graded ledger and a verdict |
| `siang:thai-pua-repair` | text extracted from a Thai PDF shows private-use glyphs or broken tone marks | maps the 27 Windows UPC-font glyphs (U+F700..U+F71A) back to standard Thai, reports any it cannot map, and, on request, rewrites the PDF's ToUnicode maps so the file itself copies and searches correctly (`pua_pdf.py`, needs pikepdf) |
| `siang:personal-voice` | you want drafts in your own voice | measures your samples, keeps a feature only if two samples show it, drafts from your facts, checks the draft against the profile |

Run one with a slash command (`/siang:humanize`) or just ask. Example prompts:

```
humanize this standup update, genre B, keep every number
```

```
use siang:technical-writing to rewrite docs/deploy.md for an on-call engineer
```

```
use siang:document-review on sop-restore.md against standard.md, review only
```

```
use siang:personal-voice: samples/ are my messages, rewrite draft.md like me
```

## How `humanize` works

It runs a fixed loop:

1. Pick the genre (A chat, B standup/PR/commit, C UI/error copy, D prose/blog/ADR) and the language.
2. Plan the grit: the concrete specifics from the source that the rewrite must keep.
3. Name every AI tell against a 33-row universal cue sheet, plus the Thai-only patterns for any
   Thai. `scripts/scan.py` runs first and lists the tells a pattern can catch (em dashes, AI
   vocabulary, chat closers, Thai spelling and date formats) with line and section; the model
   judges each hit and reads for the rest.
4. Draft, ask "what still reads AI?", then write the final.

Two rules hold throughout: no invented facts (an unverifiable claim is dropped or hedged, never
made up), and on a file only the prose changes; code blocks, commands, frontmatter and quotes
stay byte-identical.

## Layout

| Path | Contents |
|---|---|
| `skills/humanize/` | `SKILL.md`, cue sheet, universal and Thai patterns, Thai sentence structure, examples, sources, `scripts/scan.py` |
| `skills/technical-writing/` | `SKILL.md` |
| `skills/document-review/` | `SKILL.md` |
| `skills/personal-voice/` | `SKILL.md` |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `evals/` | 24 cases in `claude plugin eval`'s native layout, described in `evals/README.md` |
| `tests/` | free checks that CI runs on every push: grader self-test, version-bump hook, every § and cue reference resolves, `scan.py` finds planted tells, `pua_fix.py` maps every known glyph |

## Evals

Each case runs twice, with siang and without it, and the number to read is the difference (Δ),
not the total: plain Claude already scores high on many cases.

- 18 cases cover `humanize`, English and Thai. Several are regression guards that plain Claude
  also passes; their job is to catch siang losing to it.
- 6 cases cover the other three skills. First runs, one run per arm: `document-review` 1.00 vs
  0.57 (Δ +0.43), `personal-voice` Δ +0.22 and +0.33 on its two cases, `technical-writing` Δ +0.14 on its
  hardest case and 0.00 on two easier ones. Treat these as first signals, not settled results.

Free check, no API call: `bash tests/test-graders.sh`. A paid run is
`claude plugin eval . --scaffold --tag humanize --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
(swap the tag for `technical-writing`, `document-review` or `personal-voice`).

## Credits

siang started as the `tech-humanize` skill in
[wasikarn/method-harness](https://github.com/wasikarn/method-harness). Its knowledge base draws on:

- [blader/humanizer](https://github.com/blader/humanizer) (MIT, Copyright (c) 2025 Siqi Chen): the
  30 universal patterns: their titles, order and structure. The wording and examples, copied until
  2026-11-09, are now siang's own, paraphrased from the sources: as of that date no run of six or
  more words matches them, apart from the pattern titles, section labels, the tell phrases and word lists a rule quotes, and source names.
- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
  run by WikiProject AI Cleanup: the catalog that both humanizer and siang start from.
- [chakrit/kien-thai](https://github.com/chakrit/kien-thai) (MIT, Copyright (c) 2026 Chakrit
  Wichian): Thai discourse frames, AI tells, register and style rules.
- [Boom-Vitt/claude-thai-skills](https://github.com/Boom-Vitt/claude-thai-skills) (MIT, Copyright
  (c) 2026 Vittawat (Boom-Vitt)): Thai translation, customer-facing register, caption and
  typography guidance.

Which file adapts what, and the full license texts: [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
Thank you to all three authors for publishing their work under MIT.

## License

MIT, see [LICENSE](LICENSE).
