---
type: regex
pattern: 'new-checkout[^\n]{0,30}?(?:หลังจาก|หลัง|พอ|เมื่อ|ตอน|ถ้า|หาก)[^\n]{0,40}?(?:hotfix|#312|PR)'
match: not_contains
target: last_message
---
The flag step no longer puts its time clause last (`เปิด feature flag new-checkout กลับนะครับหลังจากที่ hotfix PR #312 ...`). Also catches `หลัง`, `พอ`, `เมื่อ`, `ตอน` after the main clause.
