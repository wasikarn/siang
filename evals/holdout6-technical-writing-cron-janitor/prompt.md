---
name: holdout6-technical-writing-cron-janitor
tags: [holdout, technical-writing]
runs: 1
max_turns: 30
timeout_seconds: 900
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`). This folder holds `janitor.py`, the script our upload hosts run from cron to delete old files, and its `README.md`, which nobody has touched in a while. `demo/` has some sample files. Rewrite `README.md` in place for an on-call engineer who has never seen the script: they have to install it on a new upload host, check it with a run that deletes nothing, then add it to cron, and they need to know what each failure looks like. Do not edit `janitor.py` or anything in `demo/`.

Your final message is one line saying what you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
