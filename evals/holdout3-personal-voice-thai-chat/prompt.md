---
name: holdout3-personal-voice-thai-chat
tags: [holdout, personal-voice]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`). The three files in `samples/` are Slack posts Nok, our on-call engineer, wrote in the team channel. `draft.md` is an incident update someone drafted for Nok to post, and it sounds nothing like Nok. Rewrite `draft.md` in place so it reads as if Nok wrote it, in Thai as Nok does. Keep every fact in it: names, numbers, ticket ids and dates. Do not edit anything in `samples/`.

Your final message is one line saying what you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
