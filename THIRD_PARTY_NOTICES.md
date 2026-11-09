# Third-party notices

siang adapts rules and examples from three MIT-licensed projects (below). Where each source is
used is listed in `skills/humanize/references.md`, "Sources adapted". Examples that were close
adaptations of a source's own examples were replaced with fresh ones on 2026-11-09. No kien-thai exemplar passage (third-party writing) was copied.

## chakrit/kien-thai

- Project: https://github.com/chakrit/kien-thai (read at commit 3695c889a23538e97ddae45c53e8b894730b41f5)
- Used for: Thai discourse frames and structure rules (`patterns-thai-structure.md` §43-§52),
  surface grammar slips (§53), headings (§54), and marked additions to §31-§40, §58 and the cue sheet.
- Files read: `skills/kien-thai/SKILL.md`, `references/ai-tells.md`, `references/grammar.md`,
  `references/style-rules.md`, `references/register.md`, `references/craft.md`.

```
MIT License

Copyright (c) 2026 Chakrit Wichian

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Boom-Vitt/claude-thai-skills

- Project: https://github.com/Boom-Vitt/claude-thai-skills (read at commit f584fb4cf420107c0e8feff63b412e7a88988927)
- Used for: pronouns (§55), dates and times (§56), apology and promises (§57), hidden characters
  (§58), and marked additions to §38-§40 and the cue sheet.
- Files read: `skills/thai-translate/SKILL.md`, `skills/thai-customer-service/SKILL.md`,
  `skills/thai-social-caption/SKILL.md`, `skills/thai-text-processing/SKILL.md`,
  `skills/thai-date-format/SKILL.md`, `AGENTS.md`.

```
MIT License

Copyright (c) 2026 Vittawat (Boom-Vitt)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## blader/humanizer

- Project: https://github.com/blader/humanizer (v2.7.0, commit a2ace14, reached method-harness on
  2026-06-10; checked against HEAD 0ef9fe5bc3572734fd3ae6c448fe00a30cd5dcf0)
- Used in: the 30 universal patterns (`skills/humanize/patterns-universal.md`, `cue-sheet.md`):
  pattern titles, order and structure. Its rule text, before/after examples and the worked example
  in `examples.md` were copied until 2026-11-09, when they were replaced with siang's own; this
  credit was missing until then.

```
MIT License

Copyright (c) 2025 Siqi Chen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Wikipedia: Signs of AI writing

The universal patterns follow the structure of
https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing (WikiProject AI Cleanup), directly and
through blader/humanizer. Wikipedia text is CC BY-SA 4.0
(https://creativecommons.org/licenses/by-sa/4.0/). Example passages quoted from that
page were replaced with fresh ones on 2026-11-09, so no CC BY-SA text remains in this MIT
repository; §7's word list still credits the page as its source.
