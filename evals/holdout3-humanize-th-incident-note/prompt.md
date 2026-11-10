---
name: holdout3-humanize-th-incident-note
tags: [regression, humanize]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) to rewrite `incident-note.md` in place so it reads like an incident note a Thai engineer on the team wrote by hand, not like AI output. Keep it in Thai, with technical terms in English as they are now. Keep every fact in it: the incident number, the times and durations, the order count, the cause and the people.

Your final message is one line saying the file is rewritten, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
