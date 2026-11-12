---
type: regex
pattern: 'จึงเรียนมา|ขอแสดงความนับถือ|เพื่อโปรดทราบ|ความไม่สะดวก|(?:^|\n)[ \t]*เรียน[ \t]|^\s*$'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: PAY-2318 refund error หลัง deploy
# must-pass: เรียนรู้จากรอบนี้: ต้องมี CI check
# must-fail: จึงเรียนมาเพื่อโปรดทราบ
# must-fail: เรียน ทีมพัฒนา
---
Sample 06 is the bank's formal email, labelled as not the user's. Its formulas are not the user's voice.
