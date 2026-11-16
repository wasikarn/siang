---
name: trigger-thai-summary-para-agent-session
tags: [trigger, thai-summary]
description: Autonomous trigger test, expects skill "siang:thai-summary", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
ขอ recap session ทำงานใน `SOURCE.md` หน่อย เขียนเป็นบันทึกสั้นๆ ลง `SUMMARY.md` เผื่อพรุ่งนี้กลับมาทำต่อจะได้ไม่ต้องไล่อ่านใหม่
ข้อความสุดท้ายตอบเป็นบรรทัดเดียวบอกชื่อไฟล์ที่เขียน
