# siang (เสียง)

A Claude Code plugin that humanizes dev and tech writing in English, Thai, and Thai-English
code-switching, so a chat message, standup, PR description, UI string, or ADR reads like a
person wrote it, not a model.

เสียง means "voice". The plugin has one skill, `siang:humanize`.

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
4. Draft, ask "what still reads AI?", then write the final.

Two rules hold throughout: no invented facts (an unverifiable claim is dropped or hedged, never
made up), and on a file only the prose changes; code blocks, commands, frontmatter and quotes stay
byte-identical.

## Layout

- `skills/humanize/`: `SKILL.md` and its references (cue sheet, universal patterns, Thai patterns,
  Thai sentence structure, examples, sources).
- `evals/`: cases in `claude plugin eval`'s native layout (`evals/README.md`).

## Credits

siang started as the `tech-humanize` skill in
[wasikarn/method-harness](https://github.com/wasikarn/method-harness). Its knowledge base draws on:

- [blader/humanizer](https://github.com/blader/humanizer) (MIT, Copyright (c) 2025 Siqi Chen): the
  30 universal patterns: their titles, order and structure. Its examples and wording, copied until
  2026-11-09, were replaced with siang's own that day.
- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
  maintained by WikiProject AI Cleanup: the catalog both humanizer and siang build on.
- [chakrit/kien-thai](https://github.com/chakrit/kien-thai) (MIT, Copyright (c) 2026 Chakrit
  Wichian): Thai discourse frames, AI tells, register and style rules.
- [Boom-Vitt/claude-thai-skills](https://github.com/Boom-Vitt/claude-thai-skills) (MIT, Copyright
  (c) 2026 Vittawat (Boom-Vitt)): Thai translation, customer-facing register, caption and
  typography guidance.

Which file adapts what, and the full license texts: [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
Thank you to all three authors for publishing their work under MIT.

## License

MIT, see [LICENSE](LICENSE).
