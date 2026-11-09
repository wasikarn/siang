---
type: regex
pattern: '^(?=[\s\S]*ไฟล์ข้อมูลทุกไฟล์)(?=[\s\S]*สิทธิ์ของผู้เข้าร่วม)[^์]*(?:์[^์]*){12}$'
match: contains
target: {source: file, path: regulation-clean.txt}
# fixture: absent
---
The lowered thanthakhat U+F70E becomes U+0E4C: 12 in the repaired file (3 in raw), with ไฟล์ and สิทธิ์ spelled right.
