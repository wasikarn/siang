---
name: holdout4-technical-writing-logtidy-readme
tags: [holdout, technical-writing]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) on `README.md`. It documents `logtidy.py`, our small script for pruning old log files, but people who follow it get errors. Rewrite `README.md` so a teammate who has never used logtidy can prune a log directory safely: what the script does, anything they must set up first, and the command with its options and their defaults. Take every fact from `logtidy.py`, `logtidy.ini` and `CHANGELOG.md` in this folder. Do not change any file other than `README.md`.

Your final message is one line naming the file you wrote, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
