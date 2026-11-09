---
type: regex
pattern: '(ม\u0E48ม\u0E49[\s\S]*){12}'
match: contains
target: {source: file, path: check.txt}
# fixture: absent
---
All 12 lines read ม่ม้ (the 12 compressed ToUnicode streams were all rewritten).
