---
type: regex
pattern: '^[ \t]*[-*•][ \t]+'
flags: m
match: not_contains
target: {source: file, path: draft.md}
---
Only one of three samples uses a bullet list, so it is not a habit; the rewrite drops the draft’s bullets for run-on prose.
