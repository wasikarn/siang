---
type: regex
pattern: '^(?![\s\S]*(?:โดยสรุป|สรุปคือ|สรุปสั้น\s?ๆ|\bTL;?DR\b))[\s\S]+'
match: contains
target: {source: file, path: db-upgrade-notice.md}
flags: i
# must-pass: เสาร์ที่ 21 พ.ย. 01:00-03:30 น. ระบบ Orders จะเขียนไม่ได้ราว 40 นาที
# must-fail: สรุปสั้นๆ: เสาร์ที่ 21 พ.ย. ระบบ Orders จะเขียนไม่ได้
# must-fail: สรุปสั้น ๆ คือเขียนไม่ได้ 40 นาที
# must-fail: TL;DR: เขียนไม่ได้ 40 นาที
---
A typical rewrite bolts on a summary line ("สรุปสั้นๆ", "TL;DR") that repeats the body; the fixture has none and the rewrite must not add one.
