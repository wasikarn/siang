---
name: holdout4-humanize-en-incident-review
tags: [holdout, humanize]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) to rewrite `INCIDENT-2291.md`, the incident review we are about to share with the payments team, so it no longer reads as machine-written. Edit the file in place. Keep every fact: numbers, ids, names, dates and versions.

Your final message is one line naming the file you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
