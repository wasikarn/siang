---
name: holdout5-personal-voice-thai-announce
tags: [holdout, personal-voice, thai]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`) on the writing samples in `samples/` and write, in my voice, the announcement I will post in our team channel about next week's release. Save it to `draft.md`. Word it however fits my voice, but every fact below must be in the draft, and do not add anything I did not list:

- ทางทีมจะดีพลอย payment-service ขึ้นโปรดักชัน ในวันพฤหัสบดีที่ 19 พฤศจิกายน เวลา 14.00 นาฬิกา
- ตั้งแต่เวลา 14.00 ถึง 14.30 นาฬิกา ขอให้ทุกท่านงดเมิร์จโค้ดเข้า main
- มีไมเกรชันเพิ่มคอลัมน์ในตาราง payments ใช้เวลาประมาณ 10 นาที
- หากเอเรอร์เรตเกิน 2% ทางทีมจะโรลแบ็กทันที

Your final message is one line naming the file you wrote, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
