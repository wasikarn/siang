---
name: holdout3-personal-voice-semicolon-memo
tags: [holdout, personal-voice]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`). The three files in `samples/` are notes Marta, our finance lead, wrote to the team. `draft.md` is an update someone drafted for her to send, and it does not sound like her at all. Rewrite `draft.md` in place so it reads as if Marta wrote it. Keep every fact in it: names, amounts, ticket ids and dates. Do not edit anything in `samples/`.

Your final message is one line saying what you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
