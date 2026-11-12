---
type: regex
pattern: '^(?=[\s\S]*เสาร์)(?=[\s\S]*(?<!\d)21\s*(?:พ\.\s?ย\.|พฤศจิกายน|/11|Nov))(?=[\s\S]*(?<!\d)0?1[:.]00)(?=[\s\S]*(?<!\d)0?3[:.]30)(?=[\s\S]*(?<!\d)0?2[:.]45)'
match: contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: วันเสาร์ที่ 21 พ.ย. 2569 เวลา 01:00-03:30 น. ถ้า 02:45 น. ยังไม่ผ่านจะ rollback
# must-pass: เสาร์ 21 พฤศจิกายน 1.00-3.30 น. ตัดสินใจ rollback ตอน 2.45 น.
# must-fail: วันเสาร์ที่ 21 พ.ย. เวลา 01:00-03:30 น.
# must-fail: วันอาทิตย์ที่ 22 พ.ย. เวลา 01:00-03:30 น. ตัดสินใจ rollback ตอน 02:45 น.
---
The window stays whole: Saturday 21 November, 01:00 to 03:30, and the 02:45 rollback call. A leading zero or a dot for the colon is fine; dropping the rollback time or the weekday is not.
