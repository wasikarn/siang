# siang (เสียง)

A Claude Code plugin for Thai and English writing: repair text extracted from Thai PDFs, remove AI tells
from prose, write in your own voice, and draft docs.

[ภาษาไทย](README.md)

## Why

Text from a model has a smell. A standup that opens with "I'm excited to share", a PR description with three
bullets of exactly equal length, a Thai notice that ends every sentence in ครับ. Readers notice within a line,
then stop trusting the rest. The other problem is a Thai PDF that copies out as garbage characters, so search
and RAG fail.

siang bundles four skills for these two problems. เสียง means "voice".

## Install

```bash
claude plugin marketplace add wasikarn/siang
claude plugin install siang@siang
```

Restart Claude Code after installing. Call a skill with a slash command (`/siang:humanize`) or just ask in
a sentence. If the task matches a skill's description, Claude picks it on its own.

## Skills

| skill | use it when | what it does |
|---|---|---|
| `siang:thai-pua-repair` | text from a Thai PDF shows private-use glyphs or broken tone marks and vowels | maps them back to standard Thai, or repairs the PDF file itself |
| `siang:humanize` | a chat message, standup, PR, commit, UI string, ADR or README reads like AI | scans for tells by pattern and rewrites; English, Thai and mixed |
| `siang:personal-voice` | you want writing that sounds like you | builds a voice profile from your own samples, then drafts in it |
| `siang:technical-writing` | you need a README, how-to, tutorial, reference page, runbook, ADR or release note | writes so the reader can finish the task; facts come from code and real command output |

Example prompts:

```
Use siang:thai-pua-repair: extract report.pdf and repair the Thai text
Use siang:humanize on this PR description draft
```

### thai-pua-repair

Maps 27 glyphs of the Windows UPC fonts (U+F700..U+F71A) back to standard Thai and reports the ones it cannot
map (U+F71B..U+F71D and other private-use sets). The scripts also run on their own:

```bash
# text: check only (exit 1 if mappable glyphs are found, exit 2 if unmappable ones remain)
python3 skills/thai-pua-repair/scripts/pua_fix.py --check extracted.txt

# text: convert and print to stdout (reads stdin when no file is given)
python3 skills/thai-pua-repair/scripts/pua_fix.py extracted.txt > fixed.txt

# PDF file: rewrite the ToUnicode maps so copy and search work (needs: pip install pikepdf)
python3 skills/thai-pua-repair/scripts/pua_pdf.py in.pdf out.pdf
```

`pua_pdf.py` changes only each font's `/ToUnicode` stream; the pages render the same.

### Document review (no longer a skill)

`document-review` became a plain doc in 0.1.38: on blind eval cases it scored the same as plain Claude.
The procedure is in [`docs/document-review/README.md`](docs/document-review/README.md), and `docs/document-review/doc_check.py` finds what a machine can check in a Markdown record: unresolved
cross-references, skipped or repeated heading and list numbers, conflicting quantities (30 minutes vs 30 s),
unexpanded acronyms, impossible dates, and missing or misordered sections. The output is candidates for a person to
judge:

```bash
python3 docs/document-review/doc_check.py runbook.md --sections "Purpose,Procedure,Rollback"
```

### humanize

`skills/humanize/` holds the step order in `SKILL.md`, a cue sheet, universal patterns (§1-§30, §59-§61), Thai
patterns (§31-§42, §53-§58), Thai sentence structure (§43-§52) and examples. `scripts/scan.py` finds the tells
a pattern can catch (em dashes, AI-flavored words, chat-style closers, Thai spelling and date formats), with line
numbers and § numbers:

```bash
python3 skills/humanize/scripts/scan.py draft.md   # or pipe into stdin
```

The output is a list of candidates, not verdicts. Read every hit before editing.

## Repo layout

| path | contents |
|---|---|
| `skills/humanize/` | `SKILL.md` (steps), register and grit notes, cue sheet, universal and Thai patterns, examples, references, `scripts/scan.py` |
| `skills/thai-pua-repair/` | `SKILL.md`, `scripts/pua_fix.py`, `scripts/pua_pdf.py` |
| `skills/personal-voice/` | `SKILL.md`, `scripts/voice_stats.py` |
| `skills/technical-writing/` | `SKILL.md` |
| `evals/` | 64 cases in `claude plugin eval` format, described in [`evals/README.md`](evals/README.md) |
| `docs/document-review/` | the document-review procedure (formerly a skill) and `doc_check.py` |
| `docs/eval-runs/` | archived eval run results ([README](docs/eval-runs/README.md)) |
| `tests/` | free checks that CI runs on every push |
| `GLOSSARY.md` | project terms |

## Evals

A skill stays in the plugin only if its with-skill mean is above 0.90 (5 runs per arm) and no case loses to the
no-skill arm by more than 0.05, on held-out cases written by an agent that never saw the skill, with graders
frozen before the run. Look at the per-case delta, not the overall score: plain Claude scores high on many cases.

Latest blind round per skill (details in `evals/README.md`):

| skill | round (version) | with-skill mean | mean Δ | worst case Δ |
|---|---|---|---|---|
| `personal-voice` | blind `holdout6` pair (0.1.39) | 0.987 | +0.04 | 0.00 |
| `humanize` | fifth round (0.1.36) | 0.98 | +0.15 | 0.00 |
| `technical-writing` | fifth round (0.1.36) | 0.956 | +0.144 | +0.11 |

The same 0.1.36 run also reran an older `technical-writing` case outside the round, which lost by −0.025.
A rerun of the earlier `personal-voice` pair on 0.1.39 (0.992, +0.033) is not counted as blind: one 0.1.39 fix
(ปล. as a P.S.) came after a reviewer pointed at a line in that pair.

`thai-pua-repair` passes with a mean delta of +0.095 (score 1.00). Method, criteria history and per-run cost are
in `evals/README.md` and `docs/eval-runs/`.

## Development

Before a commit:

```bash
claude plugin validate .
bash tests/test-graders.sh        # grader self-test (free, no API calls)
bash tests/test-section-refs.sh   # every §N and cue #N must resolve
bash tests/test-scan.sh
bash tests/test-voice.sh
bash tests/test-doc-check.sh
bash tests/test-pua.sh
bash tests/test-pua-pdf.sh        # skips without pikepdf and pdftotext
bash tests/test-version-hook.sh
```

- Any change under `skills/` needs a `version` bump in `.claude-plugin/plugin.json`; otherwise
  `claude plugin update` copies nothing. Enable the hook once per clone: `git config core.hooksPath git-hooks`.
- A new section takes the number after the last one in use (see `CLAUDE.md`). Never renumber.
- Real eval run (costs money):
  `claude plugin eval . --scaffold --tag thai-pua-repair --allow-tools "Bash,Edit,Write" --runs 1 --no-publish`
  (add `--trust-plugin` when not running in an interactive terminal)

Full rules are in [`CLAUDE.md`](CLAUDE.md).

## Credits and license

siang started as the `tech-humanize` skill in [wasikarn/method-harness](https://github.com/wasikarn/method-harness).
The knowledge comes from these sources:

- [blader/humanizer](https://github.com/blader/humanizer) (MIT, Copyright (c) 2025 Siqi Chen): the names, order
  and structure of universal patterns §1-§30 (from v2.7.0), §59-§61 and the re-scan in step 6 (from v3.1.0).
- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing), maintained by
  WikiProject AI Cleanup: the original list of tells that both humanizer and siang started from (CC BY-SA 4.0;
  commits before `27feec4` still contain text quoted from this page, see the notices).
- [chakrit/kien-thai](https://github.com/chakrit/kien-thai) (MIT, Copyright (c) 2026 Chakrit Wichian): Thai
  discourse frames, language-level AI tells and style rules.
- [Boom-Vitt/claude-thai-skills](https://github.com/Boom-Vitt/claude-thai-skills) (MIT, Copyright (c) 2026
  Vittawat (Boom-Vitt)): pronouns (§55), dates and times (§56), apologies and promises (§57), invisible characters
  (§58) and the register for customer replies.

The wording of the rules and examples has been siang's own since 2026-11-09; before that, several parts were
copied from humanizer. On 2026-11-09 a throwaway script compared the text against all four sources and found no
shared run of six or more words, except pattern names, headings, tell phrases, word lists the rules quote, and
source names. That script is not in the repo. Which file adapts what, and the full license texts, are in
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

Thanks to the three authors who published their work under MIT.

This repo is MIT licensed, see [LICENSE](LICENSE).
