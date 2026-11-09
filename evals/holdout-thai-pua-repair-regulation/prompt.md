---
name: holdout-thai-pua-repair-regulation
tags: [holdout, thai-pua-repair]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:thai-pua-repair` skill (Skill tool, `skill: "siang:thai-pua-repair"`) on `regulation-raw.txt`. It is text I extracted from a Thai university regulation PDF, and search over it misses words like ข้อมูล and ฝ่าย. Overwrite `regulation-clean.txt` (right now a raw copy) with the cleaned text, same lines in the same order. Do not edit `regulation-raw.txt`.

Your final message is one line saying how many characters you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
