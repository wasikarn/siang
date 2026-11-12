---
type: regex
pattern: 'แชท|แช็ท|inbox|อินบ็อกซ์|อินบอกซ์|ข้อความ'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: ทักแชทมาสั่งได้เลยค่ะ
# must-pass: สั่งทาง inbox ของเพจนะคะ
# must-fail: โทรมาสั่งได้เลยค่ะ
---
People order through the page chat.
