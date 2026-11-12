---
type: regex
pattern: '^(?=[\s\S]*sleep)(?=[\s\S]*(?:fake|mock|mocked|stub|stubbed|injected|virtual|test|manual) ?clock)'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: nit: `client/retry_test.go:12` uses time.Sleep, 8s per run. could we use a fake clock?
# must-pass: Line 12 of client/retry_test.go uses time.Sleep. You need to switch to a fake clock.
# must-fail: nit: `client/retry_test.go:12` takes 8 seconds. could we speed it up?
# must-fail: nit: `client/retry_test.go:12` uses time.Sleep, 8s per run.
---
Fact 3: the test sleeps for real and should use a fake clock. The draft names the sleep and a fake (or mock) clock.
