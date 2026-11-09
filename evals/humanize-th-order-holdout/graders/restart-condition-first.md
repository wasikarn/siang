---
type: regex
pattern: '(?:p99|latency|800\s*ms)[\s\S]{0,80}?(?:restart|รีสตาร์[ทต])'
match: contains
target: last_message
# fixture: absent
---
The latency condition comes before the restart action (`ถ้า p99 เกิน 800ms ติดกัน 5 นาที restart ได้เลย`), with or without a connector, across at most one line break. Deleting the sentence fails.
