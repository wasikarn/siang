---
name: holdout3-humanize-pr-rate-limiter
tags: [regression, humanize]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) to rewrite `pr-description.md` in place so it reads like a pull request description a developer on the team wrote by hand, not like AI output. Keep every fact in it: the ticket, the numbers, the endpoint and the people.

Your final message is one line saying the file is rewritten, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
