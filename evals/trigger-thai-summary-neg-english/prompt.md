---
name: trigger-thai-summary-neg-english
tags: [trigger, thai-summary]
description: Negative trigger test, expects skill "siang:thai-summary" not to fire
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Summarize `NOTES.md` in two sentences, in English, and write it to `SUMMARY.md`.
Your final message is one line naming the file you wrote.
