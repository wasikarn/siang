---
name: trigger-technical-writing
tags: [trigger]
description: Autonomous trigger test, expects skill "siang:technical-writing", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
`docs/rotate-key.md` is out of date. Rewrite it in place so an on-call engineer who has never run `bin/rotate-key` can follow it.

When you are done, your final message is one line saying what you did.
