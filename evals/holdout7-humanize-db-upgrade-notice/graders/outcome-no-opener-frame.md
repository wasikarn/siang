---
type: regex
pattern: 'ในยุคที่|ในโลกของ|ก้าวสำคัญ|ไม่ใช่แค่[^\n]{0,60}แต่|ขับเคลื่อน[^\n]{0,40}อนาคต'
match: not_contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: เสาร์นี้ทีม DBA จะอัปเกรด PostgreSQL ของระบบ Orders
# must-fail: ในยุคที่ข้อมูลคือหัวใจของธุรกิจ เราจะอัปเกรด PostgreSQL
# must-fail: นี่ไม่ใช่แค่การอัปเกรด แต่คือการลงทุน
# must-fail: มาร่วมกันขับเคลื่อนระบบไปสู่อนาคต
---
The stock frames go: the "ในยุคที่" opener, "ไม่ใช่แค่...แต่" contrast, "ก้าวสำคัญ", and the rally-cry closer about driving toward the future.
