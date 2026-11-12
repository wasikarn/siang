---
type: regex
pattern: '\p{Extended_Pictographic}'
match: not_contains
target: {source: file, path: db-upgrade-notice.md}
flags: u
# must-pass: ## สิ่งที่จะเกิดขึ้น
# must-fail: ## ✅ สิ่งที่จะเกิดขึ้น
# must-fail: ติดต่อได้ที่ #db-maint 🙏
---
Decorative emoji on headings and lines (🚀 ✅ 🔍 🙏 💪) go; a maintenance notice carries none.
