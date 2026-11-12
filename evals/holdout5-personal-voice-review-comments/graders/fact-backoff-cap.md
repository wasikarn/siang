---
type: regex
pattern: '^(?=[\s\S]*backoff)(?=[\s\S]*\b58\b)(?=[\s\S]*(?:\b(?:cap|caps|capped|uncapped|ceiling|max|maximum|limit|limits|bound|bounded|unbounded)\b|no upper))'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: blocking: `client/retry.go:58` the backoff doubles forever. could we cap it?
# must-pass: Blocking. On line 58 of client/retry.go, you must put a ceiling on the backoff.
# must-fail: blocking: `client/retry.go:58` could we cap the delay?
# must-fail: blocking: the backoff doubles with no limit, could we cap it?
---
Fact 1: the backoff at client/retry.go line 58 has no upper bound. The draft names the backoff, line 58 and a cap, ceiling or limit.
