---
type: regex
pattern: 'PAY-?2318'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: PAY-2318 refund error หลัง deploy
# must-pass: ticket PAY2318
# must-fail: PAY-2290 webhook เข้าซ้ำ
# must-fail: refund error หลัง deploy
---
The ticket id PAY-2318 survives.
