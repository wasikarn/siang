---
type: regex
pattern: '^(?=[\s\S]*api-server)(?=[\s\S]*resize-worker)(?=[\s\S]*hash)(?=[\s\S]*hostname)(?=[\s\S]*(หนึ่งสัปดาห์|1 สัปดาห์|7 วัน))(?=[\s\S]*(production[^\n]{0,6}(ยังไม่|ไม่ต้อง|รอ|ค่อย|ไว้ทีหลัง|ทีหลัง)|(ยังไม่|ไม่ต้อง)[^\n]{0,12}production))'
match: contains
target: last_message
---
The specifics survive with their polarity (A10): both service names, hash instead of hostname,
the one-week wait, and production left for later (`staging และ production` with no deferral fails).
