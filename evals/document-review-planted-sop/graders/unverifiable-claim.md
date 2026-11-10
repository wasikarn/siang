---
type: regex
pattern: '90 days[^\n]*unverifiable|unverifiable[^\n]*90 days'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
The 90-day retention claim has no source in the documents, so the ledger marks it unverifiable rather than pass (skill step 2).
