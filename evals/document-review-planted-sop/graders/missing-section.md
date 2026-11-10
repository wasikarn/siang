---
type: regex
pattern: 'rollback'
match: contains
flags: i
target: {source: file, path: review.md}
# fixture: absent
---
The ledger flags the missing Rollback section the standard requires (compliance).
