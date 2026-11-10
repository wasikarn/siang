---
name: trigger-personal-voice
tags: [trigger]
description: Autonomous trigger test, expects skill "siang:personal-voice", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
The files in `samples/` are messages I wrote. Rewrite `draft.md` in place so it sounds like me, not like a template.

When you are done, your final message is one line saying what you did.
