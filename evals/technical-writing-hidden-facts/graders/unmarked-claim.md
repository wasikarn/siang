---
type: regex
pattern: '^(?![^\n]*TODO: verify)[^\n]*encrypted'
match: not_contains
flags: m
target: {source: file, path: docs/sync-assets.md}
---
Encryption at rest is in no source: the doc drops it or marks it TODO: verify.
