---
type: regex
pattern: '^(?=[\s\S]*วิภา)[\s\S]*INC-4417'
match: contains
target: {source: file, path: draft.md}
# must-fail: พี่ rollback ให้แล้ว ดู ticket ได้เลย
---
The person (วิภา, with or without คุณ) and the incident id (INC-4417) survive the rewrite.
