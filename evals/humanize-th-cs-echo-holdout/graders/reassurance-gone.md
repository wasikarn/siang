---
type: regex
pattern: 'สบายใจได้|(?:มั่นใจ|วางใจ)ได้(?:เลย|เต็มที่)|ดูแล(?:ให้)?(?:อย่าง)?แน่นอน|ทางเรา(?:จะ)?ดูแล|ไม่ต้อง(?:กังวล|ห่วง|เป็นห่วง)'
match: not_contains
target: last_message
---
The stock reassurance line (`สบายใจได้เลยค่ะ ทางเราดูแลให้แน่นอนค่ะ`) is gone. It promises nothing
the reply has not already said. Also catches the swap to another stock comfort phrase
(`มั่นใจได้เลย`, `วางใจได้`, `ไม่ต้องกังวล`, `ไม่ต้องห่วง`).
