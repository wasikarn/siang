---
type: regex
pattern: '^(?![^\n]*TODO: verify)[^\n]*24 hours'
match: not_contains
flags: m
target: {source: file, path: docs/rotate-key.md}
---
The draft claims the old key stays valid for 24 hours. Neither the script nor anything run supports it, so the doc drops it or the line carries `TODO: verify` (step 3: unchecked facts are marked, never kept as fact).
