---
type: regex
pattern: '3 (กุมภาพันธ์|ก\.พ\.) (2570|70)'
match: contains
target: last_message
# fixture: absent
---
§56: user-facing Thai dates use the BE year with the month in letters. 2027 CE is 2570 BE, so `03/02/2027` becomes `3 กุมภาพันธ์ 2570` (or `3 ก.พ. 70`).
