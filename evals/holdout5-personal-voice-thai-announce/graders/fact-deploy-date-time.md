---
type: regex
pattern: '^(?=[\s\S]*payment)(?=[\s\S]*(?:19 ?พ\.ย\.|19 พฤศจิกายน|19/11))(?=[\s\S]*(?:14[:.]00|บ่ายสอง))'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: พฤ. 19 พ.ย. 14:00 จะ deploy payment-service ขึ้น production
# must-pass: ทีมจะดีพลอย payment-service ขึ้นโปรดักชัน วันพฤหัสบดีที่ 19 พฤศจิกายน เวลา 14.00 นาฬิกา
# must-fail: พฤ. 19 พ.ย. จะ deploy payment-service ขึ้น production
# must-fail: พฤ. 20 พ.ย. 14:00 จะ deploy payment-service ขึ้น production
---
Fact 1: payment-service goes to production on Thursday 19 Nov at 14:00. The draft names payment-service, the 19th of November and 14:00 (any format).
