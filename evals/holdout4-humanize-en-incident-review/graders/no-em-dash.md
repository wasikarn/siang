---
type: regex
pattern: '—'
match: not_contains
target: {source: file, path: INCIDENT-2291.md}
# must-pass: In total 1,284 checkouts failed before the rollback to v3.18.1 finished.
# must-pass: The response was quick: Priya Raman posted updates every ten minutes.
# must-fail: In total 1,284 checkouts failed before the rollback finished — a significant impact.
# must-fail: The response was quick — Priya posted updates.
---
The fixture has two em dashes, both in planted tells; none of the kept text has one. The rewrite has none, so it neither keeps the planted ones nor adds new ones.
