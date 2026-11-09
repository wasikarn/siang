---
name: holdout-technical-writing-config-default-prereq
tags: [holdout, technical-writing]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) to write a setup how-to for `report.py` and its `config.ini`, so a teammate who has never run it can produce their first report. Overwrite `SETUP.md` with the how-to.
Your final message is one line naming the file you wrote, nothing else.
If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
