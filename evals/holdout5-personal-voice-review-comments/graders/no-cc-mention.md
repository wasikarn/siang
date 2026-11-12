---
type: regex
pattern: '@[A-Za-z]|\bcc\b|^(?![\s\S])'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: q: where does the default of 3 attempts come from? the design doc?
# must-pass: blocking: `client/retry.go:58` could we cap the backoff?
# must-fail: cc @dana since she owns the retry bits
# must-fail: q: @marco is 3 attempts from the design doc?
---
One-off quirk (only the invoice sample): a `cc @dana` line. The draft does not cc or @-mention anyone.
