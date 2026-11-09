---
type: regex
pattern: '(?:restart|รีสตาร์[ทต])[^\n]{0,60}?(?:หาก|ถ้า|เมื่อ|กรณี|ตอน|ทุกครั้งที่)[^\n]{0,30}?(?:p99|latency|800)'
match: not_contains
target: last_message
---
The restart instruction no longer hangs its condition at the end (`restart ... ได้เลยนะครับหาก p99 latency เกิน 800ms`). Thai puts the condition first. Also catches the swap to another connector after the main clause (`ถ้า`, `เมื่อ`, `กรณี`, `ตอน`).
