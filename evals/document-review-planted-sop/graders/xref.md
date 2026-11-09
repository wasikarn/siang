---
type: regex
pattern: 'section 7|§ ?7'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
The ledger flags the broken cross-reference to section 7 (traceability).
