---
type: regex
pattern: '^(?=[\s\S]*23:10)(?=[\s\S]*order-db)(?=[\s\S]*พฤหัส)(?=[\s\S]*22:00)(?=[\s\S]*เสาร์)(?=[\s\S]*#412[^\n]*(ยังไม่|พัก|รอ[^\n]{0,10}review))(?=[\s\S]*(งด|ห้าม|อย่า|หยุด|ไม่ต้อง|พัก)[^\n]{0,12}batch)'
match: contains
target: last_message
---
The specifics survive with their polarity (A10): 23:10, `order-db`, the Thursday 22:00 slot with
Saturday as fallback, PR #412 still held (`#412 merge แล้ว` fails), and the request to stop batch
reports on production (`run batch report ได้ตามปกติ` fails). The `จะ`/`ให้` that carry the
fallback and the request (A37) are not graded as tokens; losing their meaning fails here.
