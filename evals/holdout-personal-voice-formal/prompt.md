---
name: holdout-personal-voice-formal
tags: [holdout, personal-voice]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`) to rewrite `draft.md` in place so it sounds like Margit, who wrote the three messages in `samples/`. Keep every fact in the draft. Do not edit the samples.

Your final message is one line saying the draft is rewritten, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
