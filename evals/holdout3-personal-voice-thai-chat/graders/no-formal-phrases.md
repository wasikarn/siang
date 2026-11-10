---
type: regex
pattern: 'เรียนทุกท่าน|ขอแสดงความนับถือ|ประการใด|ทางทีมงาน|เป็นที่เรียบร้อยแล้ว|ขอแจ้งให้ทราบ'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: มีอะไรทักมาได้เลยนะ
# must-fail: หากท่านมีข้อสงสัยประการใด
---
The formal letter frame (เรียนทุกท่าน, ขอแจ้งให้ทราบ, ทางทีมงาน, ประการใด, ขอแสดงความนับถือ) appears nowhere in Nok's posts and must be gone.
