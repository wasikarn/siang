---
name: holdout3-technical-writing-report-export
tags: [holdout, technical-writing]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) on `docs/exporting.md`. It is a how-to someone drafted months ago for exporting our event log with `report.py`, and support keeps getting tickets from people who followed it. Rewrite `docs/exporting.md` as a how-to that takes an analyst from a fresh checkout to an export file they can open: what they need first, the command, the options and their defaults, and where the file ends up. Base every fact on `report.py` and `report.toml` as they are now; do not edit either file.

Your final message is one line naming the most harmful mistake in the old draft, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
