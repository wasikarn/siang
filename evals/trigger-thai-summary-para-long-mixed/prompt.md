---
name: trigger-thai-summary-para-long-mixed
tags: [trigger, thai-summary]
description: Autonomous trigger test, expects skill "siang:thai-summary", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
`SOURCE.md` เป็นเอกสาร postmortem incident เมื่อสัปดาห์ก่อน ยาวเกินจะอ่านไหว ช่วยย่อให้เหลือแต่สาระ แล้วเขียนไว้ที่ `SUMMARY.md`
ข้อความสุดท้ายตอบเป็นบรรทัดเดียวบอกชื่อไฟล์ที่เขียน
