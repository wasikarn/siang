---
type: regex
pattern: '^(?=[\s\S]*noti-341)(?=[\s\S]*สมชาย)(?=[\s\S]*3\.2)[\s\S]*(?:notification|แจ้งเตือน)'
flags: i
match: contains
target: {source: file, path: draft.md}
# must-pass: fyi deploy Notification v3.2 ฮะ พี่สมชายดูแล มีปัญหาแจ้งใน NOTI-341
# must-pass: fyi ระบบแจ้งเตือน 3.2 ขึ้น prod ศุกร์นี้ฮะ คุณสมชายเป็นคนกด ติดอะไรแจ้ง noti-341
# must-fail: fyi deploy Notification v3.2 ฮะ มีปัญหาแจ้งใน NOTI-341
# must-fail: fyi deploy Notification ฮะ พี่สมชายดูแล แจ้งใน NOTI-341
---
Facts kept: the ticket NOTI-341, Somchai (สมชาย) as the owner, the system (Notification, or แจ้งเตือน in Thai) and version 3.2.
