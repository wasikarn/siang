---
type: regex
pattern: '(?<![\d.])7\s*(?:%|เปอร์เซ็นต์|percent)'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: error rate ของ /refunds ขึ้นไป 7%
# must-pass: error rate 7 เปอร์เซ็นต์
# must-fail: error rate ขึ้นไป 17%
# must-fail: error rate พุ่ง
---
The error rate (7%) survives.
