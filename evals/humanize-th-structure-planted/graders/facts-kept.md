---
type: regex
pattern: '^(?=[\s\S]*orders)(?=[\s\S]*820)(?=[\s\S]*140)(?=[\s\S]*instance)'
match: contains
target: last_message
---
The specifics survive: the orders table, p95 820 to 140 ms, and the multi-instance cache limit.
