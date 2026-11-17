---
type: regex
pattern: '(?:^|(?:\r?\n|\\n))##[ \t]+ข้อสรุป[ \t]*(?:\r?\n|\\n)[\s\S]*?(?:\r?\n|\\n)##[ \t]+ประเด็นหลัก[ \t]*(?:\r?\n|\\n)[\s\S]*?(?:\r?\n|\\n)##[ \t]+การตัดสินใจ[ \t]*(?:\r?\n|\\n)[\s\S]*?(?:\r?\n|\\n)##[ \t]+สิ่งที่ต้องทำต่อ[ \t]*(?:\r?\n|\\n)[\s\S]*?(?:\r?\n|\\n)##[ \t]+ที่ยังค้าง[ \t]*(?:(?:\r?\n|\\n)|$)'
match: contains
# fixture: absent
target: {source: file, path: SUMMARY.md}
# must-pass: ## ข้อสรุป\nเลื่อน release\n## ประเด็นหลัก\n- a\n## การตัดสินใจ\nไม่มี\n## สิ่งที่ต้องทำต่อ\nไม่มี\n## ที่ยังค้าง\nไม่มี
# must-pass: ## ข้อสรุป\n\nผลหลัก\n\n## ประเด็นหลัก\n\n- a\n- b\n\n## การตัดสินใจ\n\n- c\n\n## สิ่งที่ต้องทำต่อ\n\n- ไม่ระบุ — x — ไม่ระบุ\n\n## ที่ยังค้าง\n\n- d\n
# must-fail: ## ข้อสรุป\nผลหลัก\n## การตัดสินใจ\nไม่มี\n## ประเด็นหลัก\n- a\n## สิ่งที่ต้องทำต่อ\nไม่มี\n## ที่ยังค้าง\nไม่มี
# must-fail: ## สรุป\nผลหลัก\n## ประเด็นหลัก\n- a\n## การตัดสินใจ\nไม่มี\n## สิ่งที่ต้องทำต่อ\nไม่มี\n## ที่ยังค้าง\nไม่มี
---
The five required `##` headings (ข้อสรุป, ประเด็นหลัก, การตัดสินใจ, สิ่งที่ต้องทำต่อ, ที่ยังค้าง) all appear with exactly these names in this order. It checks presence and order only: empty sections, extra headings and repeated headings are not detected here (summary_check.py covers those). Example lines write a line break as a literal \n.
