---
type: regex
pattern: 'นะ|จ้า|เนอะ'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: rollback แล้วนะ
# must-fail: ได้ดำเนินการ rollback เรียบร้อยแล้ว
---
Nok closes lines with casual particles (นะ, จ้า) in every post; the formal draft has none. The rewrite uses at least one.
