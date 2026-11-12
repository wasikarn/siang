---
type: regex
pattern: '^(?=[\s\S]*(?:rollback|roll back|rolled back|โรลแบ))(?=[\s\S]*\b2 ?%)'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: ถ้า error rate เกิน 2% จะ rollback ทันที
# must-pass: หากเอเรอร์เรตเกิน 2% จะโรลแบ็กทันที
# must-fail: ถ้า error rate สูงผิดปกติ จะ rollback ทันที
# must-fail: ถ้า error rate เกิน 12% จะ rollback
---
Fact 4: if the error rate goes above 2% the release is rolled back at once. The draft names the rollback and the 2% threshold.
