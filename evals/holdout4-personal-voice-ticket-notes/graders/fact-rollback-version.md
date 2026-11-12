---
type: regex
pattern: '4\.11\.3'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: Nok rollback กลับ v4.11.3
# must-pass: rolled back to 4.11.3
# must-fail: rollback กลับเวอร์ชันก่อนหน้า
# must-fail: rollback กลับ v4.12.0
---
The version rolled back to (v4.11.3) survives.
