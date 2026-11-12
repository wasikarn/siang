---
type: regex
pattern: '(?<![a-z])nok(?![a-z])|(?:^|[\s(@])(?:คุณ|พี่|น้อง)?นก(?=[\s,)]|$)'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: - 14:22 Nok rollback กลับ v4.11.3
# must-pass: - 14:22 นก rollback กลับ v4.11.3
# must-fail: - 14:22 rollback กลับ v4.11.3
# must-fail: Nokia ไม่เกี่ยว รอจนกว่า error rate จะลง
---
The person who rolled back (Nok) is named, in Latin or Thai script, any case (an @ form is graded by oneoff-no-mention).
