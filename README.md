# siang (เสียง)

A Claude Code plugin that humanizes dev and tech writing in English, Thai, and Thai-English
code-switching, so a chat message, standup, PR description, UI string, or ADR reads like a
person wrote it, not a model.

เสียง means "voice". The plugin has three skills: `siang:humanize`, `siang:technical-writing` and `siang:document-review`.

## Install

```bash
claude plugin marketplace add wasikarn/siang
claude plugin install siang@siang
```

## What it does

`/siang:humanize` (or ask Claude to humanize, de-AI, or rewrite a draft) runs a fixed loop:

1. Pick the genre (A chat, B standup/PR/commit, C UI/error copy, D prose/blog/ADR) and the language.
2. Plan the grit: the concrete specifics from the source the rewrite must keep.
3. Name every AI tell against a 33-row universal cue sheet, plus the Thai-only patterns for any Thai.
   `scripts/scan.py` runs first and lists the tells a pattern can catch (em dashes, AI vocabulary,
   chat closers, Thai spelling and date formats) with line and section; the model judges each hit
   and reads for the rest.
4. Draft, ask "what still reads AI?", then write the final.

Two rules hold throughout: no invented facts (an unverifiable claim is dropped or hedged, never
made up), and on a file only the prose changes; code blocks, commands, frontmatter and quotes stay
byte-identical.

## Layout

- `skills/humanize/`: `SKILL.md` and its references (cue sheet, universal patterns, Thai patterns,
  Thai sentence structure, examples, sources), plus `scripts/scan.py`.
- `evals/`: ten cases in `claude plugin eval`'s native layout (`evals/README.md`). Read the
  with/without-siang delta (Δ), not the total: plain Claude already scores high on several cases.
- `tests/`: free checks that CI runs on every push: grader self-test, version-bump hook, every §
  and cue reference resolves, and `scan.py` finds planted tells.

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
