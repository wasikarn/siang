---
type: regex
pattern: '(?:error|เออเร่อ|2\s*%)[\s\S]{0,80}?พี่ต้น'
match: contains
target: last_message
# fixture: absent
---
The error-rate trigger comes before the call to พี่ต้น (`ถ้า error rate /v2/charge เกิน 2% page พี่ต้นเลย`). Deleting the sentence fails.
