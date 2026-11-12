---
type: regex
pattern: '@[A-Za-zก-๛]|^\s*$'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: - 14:22 Nok rollback กลับ v4.11.3
# must-pass: - 14:22 นก rollback
# must-fail: - 14:22 @nok rollback กลับ v4.11.3
# must-fail: @นก ช่วยดู migration
---
The @mention appears in one note only (04). The draft names Nok without one.
