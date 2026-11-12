---
type: regex
pattern: '^(?=[\s\S]*\b24\b)[\s\S]*(?:13[.:]00|บ่ายโมง|บ่าย ?1\b)[^\n]{0,20}(?:17[.:]00|ห้าโมง|5 ?โมง)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: มารับที่ร้านวันพุธที่ 24 ธ.ค. 13.00-17.00 น.
# must-pass: รับของวันที่ 24 ตั้งแต่บ่ายโมงถึงห้าโมงเย็น
# must-fail: มารับที่ร้านวันที่ 24 ธ.ค. ได้ทั้งวัน
# must-fail: มารับที่ร้านวันที่ 23 ธ.ค. 13.00-17.00 น.
---
Pick-up at the shop on 24 December, 13.00 to 17.00, in any time format (the dot habit is graded separately).
