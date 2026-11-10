---
type: regex
pattern: '^(?![\s\S]{320})[\s\S]*\S'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: fyi ศุกร์ที่ 22 พ.ย. 20:00 จะ deploy Notification v3.2 ขึ้น production ฮะ ระบบจะใช้ไม่ได้ประมาณ 15 นาที คุณสมชายดูแลรอบนี้ ถ้าหลัง deploy เจอปัญหาแจ้งใน NOTI-341 ได้เลย
# must-fail: fyi แจ้งให้ทุกคนทราบล่วงหน้านะฮะว่าวันศุกร์ที่ 22 พฤศจิกายน 2567 เวลา 20:00 น. ทางทีมเราจะทำการ deploy ระบบ Notification เวอร์ชัน 3.2 ขึ้นไปบน production server ซึ่งในระหว่างที่ทำการ deploy อยู่นั้นคาดว่าระบบจะไม่สามารถใช้งานได้เป็นระยะเวลาประมาณ 15 นาทีโดยประมาณ โดยคนที่จะเป็นผู้รับผิดชอบหลักในการดำเนินการครั้งนี้คือคุณสมชาย ใจดี และหากว่าหลังจาก deploy เสร็จแล้วมีใครพบเจอปัญหาใดๆ ก็ตามขอให้ช่วยแจ้งเข้ามาผ่าน NOTI-341 ด้วยนะฮะ ขอบคุณมากๆ
---
Ton's messages are one or two short lines; the rewrite stays under 320 characters (the draft is over 400).
