---
type: regex
pattern: '\b8[\s-]*(?:story[\s-]*)?(?:points?|pts?|sp)\b|refund'
flags: i
match: contains
target: {source: file, path: REPLY.md}
# fixture: absent
# must-pass: It's an 8-point item.
# must-pass: It would push out the refund status page.
# must-fail: We're too busy this sprint.
---
The draft states what taking it now would cost: the 8-point estimate or the refund page slipping.
