---
name: holdout7-humanize-db-upgrade-notice
tags: [holdout, humanize]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) to rewrite `db-upgrade-notice.md` so it reads like a person on our DBA team wrote it, not a chatbot. The readers are engineers across all product teams, who will see it posted in our company's engineering announcements channel and need to know what breaks, when, and what to do before the day.

Edit `db-upgrade-notice.md` in place. Keep it in Thai, with the English tech terms as our engineers use them. Keep every fact: versions, cluster and ticket ids, the date and times, durations, service names, the command and the error line people will grep their logs for. Do not add anything that is not in the file.

Your final message is one line naming the file you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
