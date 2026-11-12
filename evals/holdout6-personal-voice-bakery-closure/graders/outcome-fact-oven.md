---
type: regex
pattern: 'เตา|oven'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: เตาอบเสีย ช่างจะมาซ่อมค่ะ
# must-fail: พี่ขอพักร้านสามวันนะคะ
---
The reason: the oven is being repaired.
