---
type: regex
pattern: '\bIMHO\b|\bLGTM\b|🚀|^(?![\s\S])'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: blocking: `client/retry.go:58` could we cap the backoff?
# must-pass: q: is 3 attempts from the design doc?
# must-fail: IMHO the backoff needs a ceiling.
# must-fail: otherwise lgtm 🚀
---
The forwarded sample is Marco's, labelled not the user's: his IMHO, LGTM and rocket emoji are not the user's habits and must not appear.
