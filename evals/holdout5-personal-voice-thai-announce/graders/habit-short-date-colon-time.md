---
type: regex
pattern: '^(?=[\s\S]*พ\.ย\.)(?=[\s\S]*\b14:00\b)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: พฤ. 19 พ.ย. 14:00 จะ deploy payment-service ขึ้น production
# must-pass: 19 พ.ย. 14:00-14:30 ปิด merge
# must-fail: วันพฤหัสบดีที่ 19 พฤศจิกายน เวลา 14.00 นาฬิกา
# must-fail: พฤ. 19 พ.ย. 14.00 น. จะ deploy
---
Shared habit: dates as an abbreviated month ("พ.ย.", in three samples) and times as 24-hour HH:MM with a colon (four samples). The prompt says "19 พฤศจิกายน เวลา 14.00 นาฬิกา".
