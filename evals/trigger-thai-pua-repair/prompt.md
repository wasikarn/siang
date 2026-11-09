---
name: trigger-thai-pua-repair
tags: [trigger]
description: Autonomous trigger test, expects skill "siang:thai-pua-repair", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
`raw.txt` is text I extracted from a Thai PDF and the tone marks and vowels came out wrong. Fix `raw.txt` in place.

When you are done, your final message is one line saying what you did.
