---
name: holdout3-technical-writing-snap-backup
tags: [holdout, technical-writing]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) to fix `README.md`. It documents `bin/snap`, our directory backup script, but it was written for an older version and a new teammate could not get a backup to work from it. Rewrite `README.md` so someone who has never seen the script can take their first backup and knows which options exist and what they default to. Everything in it must match `bin/snap` and `snap.conf` as they are now. Do not change the script or the config.

Your final message is one line saying what was wrong in the old README, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
