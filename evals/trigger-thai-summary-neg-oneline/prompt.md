---
name: trigger-thai-summary-neg-oneline
tags: [trigger, thai-summary]
description: Negative trigger test, expects skill "siang:thai-summary" not to fire
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
ช่วยสรุป `SOURCE.md` เป็นประโยคเดียวสั้นๆ แล้วเขียนลง `SUMMARY.md`
ข้อความสุดท้ายตอบเป็นบรรทัดเดียวบอกชื่อไฟล์ที่เขียน
