---
type: regex
pattern: '\b15\b[^\n]{0,40}\b17\b'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: ร้านปิด 15-17 ธ.ค. นะคะ
# must-pass: ปิดวันจันทร์ที่ 15 ถึงวันพุธที่ 17 ธันวาคม
# must-fail: ร้านปิด 3 วันนะคะ
---
The shop is closed 15 to 17 December, in any date format.
