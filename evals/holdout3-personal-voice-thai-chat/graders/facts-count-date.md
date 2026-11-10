---
type: regex
pattern: '^(?=[\s\S]*1,?284)[\s\S]*(?:12 ?(?:พฤศจิกายน|พ\.ย\.?|nov)|12/11|2026-11-12)'
match: contains
target: {source: file, path: draft.md}
flags: i
# must-pass: 12 พ.ย. order ค้างไป 1,284 รายการ
# must-pass: เมื่อ 12/11 มี order ค้าง 1284 ตัว
# must-fail: เมื่อวานมี order ค้างพันกว่ารายการ
---
The affected order count (1,284) and the date (12 พฤศจิกายน, in full, short or numeric form, year optional) survive the rewrite.
