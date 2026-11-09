---
name: thai-pua-repair-extracted-text
tags: [thai-pua-repair, planted]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:thai-pua-repair` skill (Skill tool, `skill: "siang:thai-pua-repair"`). `raw.txt` is text extracted from a Thai PDF and its tone marks and vowels look wrong. Fix `raw.txt` in place.

Your final message is one line: how many characters you repaired and anything you could not repair.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
