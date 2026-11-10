---
name: personal-voice-thai-oneoffs
tags: [personal-voice, planted]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`). The files in `samples/` are my own Thai chat messages. Rewrite `draft.md` in place so it sounds like me, and write my voice profile to `voice.md`.

Your final message is one line saying what you changed.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
