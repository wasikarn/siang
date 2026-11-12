---
type: regex
pattern: 'เปิด[^\n]{0,40}\b18\b|\b18\b[^\n]{0,40}เปิด'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: เปิดอีกทีวันพฤหัสที่ 18 ค่ะ
# must-pass: วันที่ 18 ธ.ค. ร้านเปิดตามปกติ
# must-fail: แล้วร้านจะเปิดตามปกติค่ะ
---
The shop opens again on Thursday 18 December.
