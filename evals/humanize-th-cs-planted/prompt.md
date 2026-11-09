---
name: humanize-th-cs-planted
tags: [humanize, planted]
runs: 1
max_turns: 12
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) on `reply-draft.md`. It is a shop admin's draft reply in a LINE chat to a customer who wrote "สั่งของไป 3 วันแล้ว tracking ไม่ขยับเลยค่ะ". The admin is a woman and writes as the shop (a human reply to a customer, genre C in content but a live conversation). The courier has given the shop no delivery date. No writing sample is available.

Work through the skill's loop (draft, "still AI" bullets, final) in your turn, then make your final message the final rewrite only, verbatim, with nothing before or after it.
