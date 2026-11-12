---
type: regex
pattern: '\bFWIW\b|for what it''?s worth|^(?![\s\S])'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: nit: `client/retry_test.go:12` sleeps for 8s. could we use a fake clock?
# must-pass: q: is 3 from the design doc?
# must-fail: FWIW the old client had no backoff cap either.
# must-fail: fwiw 3 attempts sounds fine to me
---
One-off quirk (only the job-queue sample): an aside opening with FWIW. The draft has none.
