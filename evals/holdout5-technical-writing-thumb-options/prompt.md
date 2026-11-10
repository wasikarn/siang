---
name: holdout5-technical-writing-thumb-options
tags: [holdout, technical-writing]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) to update `OPTIONS.md`, the option reference for our image thumbnail tool `thumb.py`. We just shipped 3.0.0 (see `CHANGELOG.md`) and the page still describes 2.x. Make it a correct reference for 3.0.0: every option with what it does and its default. Also add a migration note so someone upgrading from 2.x knows what to change in the commands and scripts they already run. `thumb.py` is the source of truth. Do not change `thumb.py` or `CHANGELOG.md`.

Your final message is one line naming the file you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
