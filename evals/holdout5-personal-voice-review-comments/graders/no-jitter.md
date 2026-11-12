---
type: regex
pattern: 'jitter|^(?![\s\S])'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: blocking: `client/retry.go:58` could we cap the backoff?
# must-pass: blocking: the delay keeps doubling with no ceiling.
# must-fail: blocking: `client/retry.go:58` could we cap the backoff and add jitter?
# must-fail: nit: some Jitter would help too.
---
Invention check: the user listed four points and said to add none. Jitter is the obvious backoff suggestion a reviewer adds; it must not appear.
