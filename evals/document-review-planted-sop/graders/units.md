---
type: regex
pattern: '30 ?(min|s)\b[\s\S]*(contradict|inconsisten|mismatch|disagree|unit)|(contradict|inconsisten|mismatch|disagree|unit)[\s\S]*30 ?(min|s)\b'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
The ledger flags the 30 minutes versus 30 s wait (precision).
