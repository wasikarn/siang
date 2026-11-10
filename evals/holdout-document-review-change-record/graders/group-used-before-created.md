---
type: regex
pattern: 'fw-batch-b'
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: step 2 applies rules to host group fw-batch-b, which step 4 only creates later.
