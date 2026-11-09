---
type: regex
pattern: '30 ?(min(utes?)?|s(ec(onds?)?)?)\b[\s\S]*(contradict|inconsisten|mismatch|disagree)|(contradict|inconsisten|mismatch|disagree)[\s\S]*30 ?(min(utes?)?|s(ec(onds?)?)?)\b'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
The ledger flags the 30 minutes versus 30 s wait (precision).
