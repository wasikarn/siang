---
type: regex
pattern: '^(?![\s\S]*\b\d{1,2}:\d{2}\b)[\s\S]*\b13\.00\b'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: มารับที่ร้านวันที่ 24 ธ.ค. 13.00-17.00 น.
# must-fail: มารับที่ร้านวันที่ 24 ธ.ค. 13:00-17:00 น.
# must-fail: รับของวันที่ 24 ตั้งแต่บ่ายโมงถึงห้าโมงเย็น
---
Every time in the samples is written with a dot ("8.30", "10.00-16.00 น."), never a colon or spelled out; "1pm to 5pm" comes out as "13.00-17.00".
