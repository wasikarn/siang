---
type: regex
pattern: '^(?![\s\S]*(?:ครับ|ค่ะ))[\s\S]*ฮะ'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: fyi deploy คืนวันศุกร์ฮะ
# must-pass: fyi ศุกร์นี้ deploy นะฮะ
# must-fail: fyi deploy คืนวันศุกร์ครับ
# must-fail: fyi deploy คืนวันศุกร์นะ
# must-fail: fyi deploy ศุกร์ฮะ ขอบคุณครับ
---
Every sample uses the particle ฮะ and none uses ครับ; the rewrite does the same (the draft ends on ครับ).
