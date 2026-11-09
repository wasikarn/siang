---
name: thai-pua-repair-pdf-compressed
tags: [thai-pua-repair, planted]
runs: 1
max_turns: 25
timeout_seconds: 900
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:thai-pua-repair` skill (Skill tool, `skill: "siang:thai-pua-repair"`). `in.pdf` is a Thai PDF whose extracted text shows broken tone marks and vowels. Repair the PDF itself: write the fixed file to `out.pdf` so its text extracts as standard Thai on every line. Then overwrite `check.txt` with the output of `pdftotext -enc UTF-8 out.pdf -`.

Your final message is one line: what you changed and anything you could not repair.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
