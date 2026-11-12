---
type: regex
pattern: '^(?![\s\S]*\p{Extended_Pictographic})[\s\S]+'
match: contains
target: {source: file, path: draft.md}
flags: u
# fixture: absent
# must-pass: เตาอบเสีย พี่ขอปิดร้าน 15-17 ธ.ค. นะคะ
# must-fail: เตาอบเสีย พี่ขอปิดร้าน 15-17 ธ.ค. นะคะ 🥲
# must-fail: สโตเลนมาแล้ว 🎄
---
Only one sample (02) has an emoji; it is a one-off, so the draft has none.
