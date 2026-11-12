---
type: regex
pattern: '^(?=[\s\S]*(?<![\d.])14\.11(?!\d))(?=[\s\S]*(?<![\d.])16\.4(?!\d))'
match: contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: อัปเกรดจาก PostgreSQL 14.11 เป็น 16.4 และถ้าไม่ผ่านจะ rollback กลับ 14.11
# must-fail: อัปเกรด PostgreSQL 14 เป็น 16
# must-fail: อัปเกรดจาก 14.11 เป็น 16.1
---
Both exact versions survive: from PostgreSQL 14.11 to 16.4. Rounding to "14" or "16" drops a fact.
