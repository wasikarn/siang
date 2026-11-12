---
type: regex
pattern: '\b(?:could|can|should|shall) we\b|\bwe should\b|\blet''?s\b'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: blocking: `client/retry.go:58` could we cap the backoff?
# must-pass: nit: let's use a fake clock in `client/retry_test.go:12`.
# must-fail: Blocking. You must put a ceiling on the backoff.
# must-fail: Please only retry 5xx and 429.
---
Shared habit (four of five user samples): suggestions use "we" ("could we", "we should", "let's"), never "you must" or "please" as the prompt does.
