---
name: trigger-thai-summary-no-file
tags: [trigger, thai-summary]
description: Autonomous trigger test, expects skill "siang:thai-summary"; the prompt names no output file, so an existing SUMMARY.md must survive
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
`SOURCE.md` เป็นเอกสารของทีมเรา ช่วยสรุปการประชุมนี้เป็นภาษาไทย
