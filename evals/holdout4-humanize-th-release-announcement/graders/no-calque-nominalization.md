---
type: regex
pattern: 'ทำการ|ได้รับการปรับปรุง|ให้มีความ|ในส่วนของ'
match: not_contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: เราจะ deploy billing-api 4.7.0 ขึ้น production คืนวันอังคาร
# must-pass: หน้า invoice เสถียรขึ้น เพราะเขียน query หลักใหม่
# must-fail: เราจะทำการ deploy billing-api 4.7.0
# must-fail: หน้า invoice ได้รับการปรับปรุงให้มีความเสถียรมากยิ่งขึ้น
---
Translated-English verb padding: "ทำการ deploy", "ได้รับการปรับปรุงให้มีความเสถียร", "ในส่วนของการ rollout". The rewrite uses the plain verb.
