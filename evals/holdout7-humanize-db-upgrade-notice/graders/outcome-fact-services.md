---
type: regex
pattern: '^(?=[\s\S]*orders-api[^\n]*503|[\s\S]*503[^\n]*orders-api)(?=[\s\S]*POST /orders)(?=[\s\S]*billing-worker)(?=[\s\S]*report-cron)'
match: contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: orders-api จะตอบ 503 สำหรับ POST /orders ส่วน billing-worker กับ report-cron หยุดไปก่อน
# must-fail: orders-api จะตอบ error สำหรับ POST /orders ส่วน billing-worker กับ report-cron หยุดไปก่อน
# must-fail: orders-api จะตอบ 503 สำหรับ POST /orders ส่วน worker อื่นๆ หยุดไปก่อน
---
The impact line was fine as written and must keep its content: orders-api answers 503 for POST /orders, and billing-worker and report-cron pause.
