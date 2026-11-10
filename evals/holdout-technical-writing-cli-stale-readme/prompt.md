---
name: holdout-technical-writing-cli-stale-readme
tags: [holdout, technical-writing]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) to rewrite `README.md` for the `snapshot` script in this folder, so a new user can set it up and take their first snapshot. Overwrite `README.md` with the new version.
Your final message is one line naming the file you wrote, nothing else.
If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
