---
type: regex
pattern: '—'
match: not_contains
target: {source: file, path: PR_DESCRIPTION.md}
# must-pass: This adds a rate limiter to `GET /v2/search`.
# must-fail: This adds a rate limiter to `GET /v2/search` — a big win.
---
No em dash; the fixture's one hangs a puffed-up aside off the opening sentence.
