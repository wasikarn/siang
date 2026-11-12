---
type: regex
pattern: '\bprobably\b'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: Probably 0 orders lost. Priya will confirm.
# must-pass: No orders lost, probably.
# must-fail: We believe no orders were lost.
# must-fail: Likely no orders were lost.
---
The user's hedge word is "probably" (4 of 5 samples), and the reconciliation fact is uncertain.
