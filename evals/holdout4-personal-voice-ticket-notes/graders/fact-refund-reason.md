---
type: regex
pattern: 'refund_reason'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: migration ที่เพิ่ม column refund_reason ไม่ได้อยู่ใน release
# must-pass: missing refund_reason migration
# must-fail: migration ไม่ได้อยู่ใน release
# must-fail: column refund reason หาย
---
The missing column (refund_reason) survives.
