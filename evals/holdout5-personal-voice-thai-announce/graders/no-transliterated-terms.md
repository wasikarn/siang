---
type: regex
pattern: 'ดีพลอ|ดีพลอย|โปรดักชั่น|โปรดักชัน|เมิร์จ|เมิร์ก|ไมเกรช|ไมเกรต|โรลแบ|เอเรอร์|เออเร่อ|เออเรอร์|^(?![\s\S])'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: พฤ. 19 พ.ย. 14:00 จะ deploy payment-service ขึ้น production
# must-pass: ถ้า error rate เกิน 2% จะ rollback ทันที
# must-fail: ทีมจะดีพลอย payment-service ขึ้นโปรดักชัน
# must-fail: หากเอเรอร์เรตเกิน 2% จะโรลแบ็กทันที
---
Shared habit (all five user samples): English tech terms stay in Latin script (deploy, production, merge, migration, rollback, error rate). The prompt gives them transliterated into Thai; the draft must not keep that.
