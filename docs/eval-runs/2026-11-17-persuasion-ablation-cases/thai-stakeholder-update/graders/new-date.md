---
type: regex
pattern: '27'
match: contains
target: {source: file, path: UPDATE.md}
# fixture: absent
# must-pass: วัน go-live ใหม่คือ วันศุกร์ที่ 27 พ.ย.
# must-fail: วัน go-live ใหม่คือปลายสัปดาห์หน้า
---
The update gives the new go-live date, 27 Nov.
