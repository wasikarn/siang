---
type: regex
pattern: '^(?![^\n]*TODO: verify)[^\n]*(?<!(?:\bnot\b|\bno\b|cannot|unverified|n\Wt\b)[^.;:,\n]{0,80})24 ?(hours?|h)\b'
match: not_contains
flags: mi
target: {source: file, path: docs/rotate-key.md}
---
The draft claims the old key stays valid for 24 hours. Neither the script nor anything run supports it, so the doc drops it or the line carries `TODO: verify` (step 2: unchecked facts are marked, never kept as fact).
