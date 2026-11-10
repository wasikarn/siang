---
type: regex
pattern: '^[^\n]{120,}$'
match: not_contains
target: {source: file, path: draft.md}
flags: m
---
Nok writes one short chat line per thought (every sample line is under 60 characters); the draft has paragraph lines over 200. No line of the rewrite may reach 120 characters.
