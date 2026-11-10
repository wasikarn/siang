# siang (เสียง)

**Claude Code skills for Thai text: repair Thai PDF text, write in your own voice, remove AI tells.**

[ภาษาไทย](README.md)

> Text from a model has a smell.

A standup that opens with "I'm excited to share", a PR description with three bullets of equal
length, a Thai notice that ends every sentence in ครับ and leans on "ซึ่ง" and "โดย". Readers
notice within a line, and then they stop trusting the rest.

siang is a Claude Code plugin with five skills: repairing text extracted from a Thai PDF (`thai-pua-repair`), removing that smell in English, Thai and
Thai-English code-switching (`humanize`), writing in your own voice (`personal-voice`), drafting docs (`technical-writing`) and reviewing records (`document-review`). เสียง means "voice".

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

## The skill

**`siang:thai-pua-repair`**

- Use it when: text extracted from a Thai PDF shows private-use glyphs or broken tone marks
- What it does: maps the 27 Windows UPC-font glyphs (U+F700..U+F71A) back to standard Thai, reports any it cannot map, and, on request, rewrites the PDF's ToUnicode maps so the file itself copies and searches correctly (`pua_pdf.py`, needs pikepdf)

Run it with a slash command (`/siang:thai-pua-repair`) or just ask. Example prompt:
```
use siang:thai-pua-repair: extract report.pdf and fix the Thai text
```

## The other four skills

- `humanize`: removes AI tells from dev/tech writing. `skills/humanize/` holds the loop in `SKILL.md`, a 33-row universal cue sheet, the Thai-only
  patterns, Thai sentence structure, worked examples, and `scripts/scan.py`, which lists the tells a pattern can catch (em dashes, AI vocabulary,
  chat closers, Thai spelling and date formats) with line and section.
- `personal-voice`: builds a voice profile from your own samples, then drafts in it.
- `technical-writing` and `document-review`: draft a doc a reader can use, and audit a record against its standard.

All four were restored in 0.1.33 under the pass rule in `evals/README.md` (with-skill mean above 0.90, no case losing by more than 0.05). Earlier versions
also required a mean Δ of +0.05 over plain Claude; that clause was dropped on 2026-11-10 and the recorded Δ results stay as history.

## Layout

| Path | Contents |
|---|---|
| `skills/humanize/` | `SKILL.md` loop, cue sheet, universal and Thai patterns, Thai sentence structure, examples, sources, `scripts/scan.py` |
| `skills/personal-voice/`, `skills/technical-writing/`, `skills/document-review/` | one `SKILL.md` each |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `evals/` | 52 cases in `claude plugin eval`'s native layout, described in `evals/README.md` |
| `tests/` | free checks that CI runs on every push: grader self-test, version-bump hook, every § and cue reference resolves, `scan.py` finds planted tells, `pua_fix.py` maps every known glyph, `pua_pdf.py` repairs a real PDF end to end |

## Evals

Each case runs in two arms, with siang and without it, and the number to read is the difference (Δ),
not the total: plain Claude already scores high on many cases.

- 18 cases cover `humanize`, English and Thai (removed in 0.1.28, restored in 0.1.33). Several are regression guards that plain Claude
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
- Held-out cases for the other four skills (written by an agent that never saw the skills' steps) were run once
  more after the graders were frozen, 5 runs per arm, under a rule set before the run (see `evals/README.md`):
  `thai-pua-repair` mean Δ +0.095 (score 1.00) passes.
- Verdicts under the current rule (with-skill mean above 0.90, no case losing by more than 0.05), each on the text it was measured on:
  `personal-voice` 0.975 (the 0.1.32 text, worst case −0.025); `humanize` 0.94 (its last `SKILL.md`, no case below −0.03);
  `document-review` 0.985 (worst −0.03); `technical-writing` 0.985 (after the grader fixes, worst −0.03). The restored text was then run on new blind cases (`holdout3-*`, `holdout4-*`): `humanize`, `document-review`, `personal-voice` 1.00; `technical-writing` lost 0.07 on `report-export` in the second round (a loose grader, see `evals/README.md`) and scored 1.00 on two later cases. The Δ column in `evals/README.md`
  is a record of the earlier +0.05 rule; none of these skills met it, and that is why they were removed in 0.1.26 to 0.1.32.
- 5 `trigger` cases, one per skill, check that the skill fires from the task alone, without being named: it fired in every run.

Free check, no API call: `bash tests/test-graders.sh`. A paid run is
`claude plugin eval . --scaffold --tag thai-pua-repair --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
(add `--trust-plugin` outside an interactive terminal).

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
