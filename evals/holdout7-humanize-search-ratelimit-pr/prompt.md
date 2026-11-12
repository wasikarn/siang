---
name: holdout7-humanize-search-ratelimit-pr
tags: [holdout, humanize]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) to rewrite `PR_DESCRIPTION.md` so it reads like the engineer who wrote the code, not a chatbot. The readers are the backend reviewers on my team, who know the codebase and want to see what changed, why, how it rolls out and what is tested.

Edit `PR_DESCRIPTION.md` in place. Keep it in English. Keep every fact: numbers, dates, ids, flag, metric and key names, the config block and the testing checklist as it stands. Do not add anything that is not in the file.

Your final message is one line naming the file you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
