---
type: regex
pattern: '^(?![^\n]*TODO: verify)[^\n]*(?<!(?:\bnot\b|\bno\b|cannot|unverified|n\Wt\b)[^.;:,\n]{0,80})encrypt'
match: not_contains
flags: mi
target: {source: file, path: docs/sync-assets.md}
---
Encryption at rest is in no source: the doc drops it or marks it TODO: verify.
