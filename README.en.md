# siang (เสียง)

**Claude Code skills for dev and tech writing that reads like a person wrote it.**

[ภาษาไทย](README.md)

> Text from a model has a smell.

A standup that opens with "I'm excited to share", a PR description with three bullets of equal
length, a Thai notice that ends every sentence in ครับ and leans on "ซึ่ง" and "โดย". Readers
notice within a line, and then they stop trusting the rest.

siang is a Claude Code plugin that removes that smell in English, Thai, and Thai-English
code-switching, and covers the nearby jobs: writing a doc a reader can follow, keeping your own voice, and repairing text extracted from a Thai PDF. เสียง means "voice".

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

## The four skills

| Skill | Use it when | What it does |
|---|---|---|
| `siang:humanize` | a draft reads like a model wrote it | names every AI tell against a cue sheet, rewrites, then re-reads for what is left |
| `siang:technical-writing` | you need a how-to, tutorial, reference page, runbook or README | picks one Diátaxis quadrant per doc, takes facts from the code and from commands it runs, marks anything unchecked `TODO: verify` |
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
| `skills/personal-voice/` | `SKILL.md` |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `evals/` | 36 cases in `claude plugin eval`'s native layout, described in `evals/README.md` |
| `tests/` | free checks that CI runs on every push: grader self-test, version-bump hook, every § and cue reference resolves, `scan.py` finds planted tells, `pua_fix.py` maps every known glyph, `pua_pdf.py` repairs a real PDF end to end |

## Evals

Each case runs in two arms, with siang and without it, and the number to read is the difference (Δ),
not the total: plain Claude already scores high on many cases.

- 18 cases cover `humanize`, English and Thai. Several are regression guards that plain Claude
  also passes; their job is to catch siang losing to it. Measured gain is narrow: mean Δ +0.04 over the 18 cases
  in both runs below, 3 runs per arm each.
  - Opus 5.5 (2026-11-09, siang 0.1.16, the repo's prompts): all 54 with-arm runs passed, but plain Claude nearly
    did too. A with-arm run cost 2.1 times a plain one ($0.216 vs $0.102).
  - Sonnet 5.5, with prompts that ask for a human-sounding rewrite with no genre letter or loop steps, but still add
    "(use the `siang:humanize` skill if you have it)": siang did not pass every case. It failed the old echo-back
    grader in th-cs-echo-planted (0.67, same as plain; the outputs were never read) and the `VM 3 ใบ` grader in
    th-grammar-planted (0.53 vs
    plain 0.60). The gain sits in Thai dates and times, Thai standup register, leaving a clean Thai chat message
    alone, and subtle English tells. A with-arm run cost 1.7 times a plain one ($0.081 vs $0.048).

  Both runs' results (scores, costs and every grader verdict) are in [`docs/eval-runs/`](docs/eval-runs/); the
  Sonnet run's prompts are recorded there, but the repo's prompts still name the skill, so rerunning them will not
  reproduce the Sonnet figures exactly. After the deep-audit fixes (0.1.24), all 14 Thai cases reran with-arm only
  at 1.00 in 42 of 42 runs.
- Held-out cases for the other three skills (written by an agent that never saw the skills' steps) were run once
  more after the graders were frozen, 5 runs per arm, under a rule set before the run (see `evals/README.md`):
  `personal-voice` mean Δ +0.08 (score 0.95), `technical-writing` Δ +0.08 (0.98) and `thai-pua-repair` Δ +0.12 (1.00)
  pass. The first two clear the +0.05 bar narrowly, within run-to-run noise.
- `document-review` failed the rule (mean Δ −0.02 on its two held-out cases; plain Claude finds the same defects).
  It was removed as a skill in 0.1.26 and its checklist kept as a plain doc, `docs/document-review-checklist.md`.
- 4 `trigger` cases check that each skill fires from the task alone, without being named: all fired in every run (a fifth, for `document-review`, went with that skill).

Free check, no API call: `bash tests/test-graders.sh`. A paid run is
`claude plugin eval . --scaffold --tag humanize --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
(swap the tag for `technical-writing`, `personal-voice` or `thai-pua-repair`; add
`--trust-plugin` outside an interactive terminal).

## Credits

siang started as the `tech-humanize` skill in
[wasikarn/method-harness](https://github.com/wasikarn/method-harness). Its knowledge base draws on:

- [blader/humanizer](https://github.com/blader/humanizer) (MIT, Copyright (c) 2025 Siqi Chen): the
  titles, order and structure of universal patterns §1-§30 (from its v2.7.0), and §59-§61 plus the
  step-6 re-scan (from its v3.1.0).
- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
  run by WikiProject AI Cleanup: the catalog that both humanizer and siang start from (CC BY-SA 4.0;
  commits before `27feec4` still quote it, see the notices).
- [chakrit/kien-thai](https://github.com/chakrit/kien-thai) (MIT, Copyright (c) 2026 Chakrit
  Wichian): Thai discourse frames, AI tells, register and style rules.
- [Boom-Vitt/claude-thai-skills](https://github.com/Boom-Vitt/claude-thai-skills) (MIT, Copyright
  (c) 2026 Vittawat (Boom-Vitt)): pronouns (§55), dates and times (§56), apology and promises (§57),
  hidden characters (§58), and customer-facing register.

The rule wording and examples are siang's own since 2026-11-09. Until then much of the humanizer
text was copied. A scratch script run on 2026-11-09 against these four sources found no shared run
of six or more words, apart from pattern titles, section labels, the tell phrases and word lists a
rule quotes, and source names. That script is not in the repo.

Which file adapts what, and the full license texts: [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
Thank you to all three authors for publishing their work under MIT.

## License

MIT, see [LICENSE](LICENSE).
