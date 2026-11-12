---
type: regex
pattern: '`(?:client/)?retry\.go:58`'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: blocking: `client/retry.go:58` the backoff never stops doubling.
# must-pass: blocking: `retry.go:58` could we cap the backoff?
# must-fail: Blocking. On line 58 of client/retry.go, you must put a ceiling on the backoff.
# must-fail: blocking: client/retry.go line 58 never stops doubling.
---
Shared habit (all five user samples): code is cited as `path/file.go:LINE` in backticks. The prompt says "line 58 of client/retry.go"; the draft must restyle it.
