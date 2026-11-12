---
name: holdout6-personal-voice-bakery-closure
tags: [holdout, personal-voice]
runs: 1
max_turns: 30
timeout_seconds: 900
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`) on the writing samples in `samples/` and write my next post for my bakery's Facebook page, in Thai and in my voice, saved to `draft.md`. The samples are my last few posts on the page.

Facts it must contain:
- The shop is closed Monday 15 to Wednesday 17 December because the oven is being repaired.
- The shop opens again on Thursday 18 December.
- Pre-orders are open for Christmas stollen, 390 baht a loaf.
- Pre-orders close on Sunday 21 December; people order through the page chat.
- Pick-up is at the shop on Wednesday 24 December, 1pm to 5pm.

Do not add any point I did not list.

Your final message is one line naming the file you wrote, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
