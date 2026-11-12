---
type: regex
pattern: '^(?![\s\S]*(?:^|\n)[ \t]*(?:\d+\.|[-*•+])[ \t])[\s\S]+'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: 1) Pause any batch job that writes to orders before 13:45 UTC.
# must-pass: Pause your batch jobs before 13:45 UTC and hold deploys until 16:00 UTC.
# must-fail: 1. Pause any batch job that writes to orders before 13:45 UTC.
# must-fail: - Pause any batch job that writes to orders before 13:45 UTC.
# must-fail: * Do not deploy anything that touches orders-db.
---
When the samples list steps they number them "1)", never "1." or bullets. A draft in prose passes; a list in another style fails.
