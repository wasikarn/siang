---
type: regex
pattern: '^(?![\s\S]*(?:ดีพลอย|เซิร์ฟเวอร์|ทิกเก็ต))[\s\S]*deploy'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: fyi deploy Notification v3.2 ขึ้น prod ฮะ
# must-pass: fyi จะ Deploy ขึ้น production server ศุกร์นี้ฮะ
# must-fail: fyi จะดีพลอย Notification ฮะ
# must-fail: fyi deploy ขึ้นเซิร์ฟเวอร์ Production ฮะ
# must-fail: fyi มีปัญหาแจ้งในทิกเก็ต NOTI-341 หลัง deploy ฮะ
---
Ton writes tech terms in English (deploy, rollback, config), never the Thai transliterations ดีพลอย, เซิร์ฟเวอร์ or ทิกเก็ต that the draft uses.
