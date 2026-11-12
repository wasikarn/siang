---
type: regex
pattern: '(?<!\d)40\s*นาที'
match: contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: ฐานข้อมูลจะเป็น read-only ราว 40 นาที
# must-pass: read-only ประมาณ 40นาที
# must-fail: read-only ประมาณครึ่งชั่วโมง
---
The read-only period, about 40 minutes, survives as a number of minutes.
