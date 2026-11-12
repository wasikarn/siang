---
type: regex
pattern: '—'
match: not_contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: อัปเกรดครั้งนี้ช่วยเรื่องประสิทธิภาพ เราจะได้รองรับโหลดที่โตขึ้น
# must-fail: อัปเกรดครั้งนี้ช่วยเรื่องประสิทธิภาพ — เราจะได้รองรับโหลดที่โตขึ้น
---
Em dashes are a machine tell in Thai prose, where people use a space or a new sentence; the fixture has two.
