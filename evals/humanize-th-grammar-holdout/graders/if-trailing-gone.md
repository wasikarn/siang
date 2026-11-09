---
type: regex
pattern: '(?:logout|ล็อกเอาต์|log out|หลุด|เด้งออก)[^\n]{0,20}(?:ถ้า|หาก|เมื่อ|ตอน(?:ที่)?|ทุกครั้งที่)\s*(?:มี\s*)?pod'
match: not_contains
target: last_message
---
The condition is no longer tacked on after the result in English order
(`user จะโดน logout ถ้า pod ถูก evict`). Thai puts the condition first:
`ถ้า pod ถูก evict ... user จะโดน logout`.
