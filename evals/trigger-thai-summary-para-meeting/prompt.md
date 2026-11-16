---
name: trigger-thai-summary-para-meeting
tags: [trigger, thai-summary]
description: Autonomous trigger test, expects skill "siang:thai-summary", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
ช่วยย่อ `SOURCE.md` ซึ่งเป็น transcript ประชุมทีมเมื่อเช้านี้ แล้วเขียนลง `SUMMARY.md` ให้หน่อย ผมไม่ได้เข้าประชุมเลยอยากรู้แค่ว่าตกลงอะไรกันไป
ข้อความสุดท้ายตอบเป็นบรรทัดเดียวบอกชื่อไฟล์ที่เขียน
