---
type: regex
pattern: '^(?![\s\S]*(?:ดีพลอ|โรลแบ็?[กค]|โปรดักชั่?น|สเตจจิ้?ง|(?<!บ)ล็อ[กค]|ไมเกรชั่?น|มายเกรชั่?น|ฮอตฟิกซ์|พีอาร์))(?=[\s\S]*[ก-ฮ])[\s\S]*(?:deploy|rollback)'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: - 14:05 deploy v4.12.0 ขึ้น prod
# must-pass: - 14:22 Nok rollback กลับ v4.11.3 แล้วปกติ
# must-fail: - 14:05 ดีพลอย v4.12.0 ขึ้นโปรดักชัน แล้ว deploy ใหม่
# must-fail: - 14:05 deployed v4.12.0 to prod
---
The user writes Thai with a fixed set of English terms in Latin script (all 5 notes). The draft is Thai, uses deploy or rollback in Latin script, and transliterates none of the set.
