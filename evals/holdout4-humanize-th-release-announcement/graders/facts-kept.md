---
type: regex
pattern: '^(?=[\s\S]*4\.7\.0)(?=[\s\S]*(?:(?:10|๑๐)\s*(?:พ\.ย\.|พฤศจิกายน|Nov)|2026-11-10|10/11/))(?=[\s\S]*840)(?=[\s\S]*310)(?=[\s\S]*20\s*(?:%|เปอร์เซ็นต์))(?=[\s\S]*(?:5|๕)\s*นาที)(?=[\s\S]*ณัฐวุฒิ)(?=[\s\S]*BILL-3317)'
match: contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: deploy billing-api 4.7.0 คืนวันอังคารที่ 10 พ.ย. 22:00 p95 จาก 840 ms เหลือ 310 ms เปิดให้ tenant 20% ก่อน ช้าลงราว 5 นาที on-call คุณณัฐวุฒิ ดู BILL-3317
# must-pass: 4.7.0 / 2026-11-10 / p95 840 -> 310 ms / 20 เปอร์เซ็นต์ / 5 นาที / ณัฐวุฒิ / BILL-3317
# must-fail: deploy billing-api 4.7.0 คืนวันอังคาร p95 จาก 840 ms เหลือ 310 ms เปิดให้ tenant 20% ก่อน ช้าลงราว 5 นาที on-call คุณณัฐวุฒิ ดู BILL-3317
# must-fail: 4.7.0 / 10 พ.ย. / p95 ลดลงเกือบสามเท่า / 20% / 5 นาที / ณัฐวุฒิ / BILL-3317
---
Seven facts survive, in any wording or digit style: billing-api 4.7.0, 10 November, p95 840 ms to 310 ms, 20% of tenants first, about 5 minutes of slower requests, คุณณัฐวุฒิ, ticket BILL-3317.
