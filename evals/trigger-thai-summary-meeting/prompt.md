---
name: trigger-thai-summary-meeting
tags: [trigger, thai-summary]
description: Autonomous trigger test, expects skill "siang:thai-summary", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
`SOURCE.md` เป็นเอกสารของทีมเรา ช่วยสรุปการประชุมนี้ เป็นภาษาไทย แล้วเขียนลง `SUMMARY.md`
ข้อความสุดท้ายตอบเป็นบรรทัดเดียวบอกชื่อไฟล์ที่เขียน
