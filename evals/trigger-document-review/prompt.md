---
name: trigger-document-review
tags: [trigger]
description: Autonomous trigger test, expects skill "siang:document-review", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Please go through `docs/sop-restore.md` against `docs/standard.md` and tell me what is wrong with it. Write what you find to `review.md`. Do not change the SOP.

When you are done, your final message is one line saying what you did.
