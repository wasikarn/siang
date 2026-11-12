---
type: regex
pattern: '^(?=[\s\S]*\b400\b)(?=[\s\S]*\b429\b)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: blocking: we should not retry on a 400. only 5xx and 429.
# must-pass: Blocking. You should not retry on a 400 response. Please only retry 5xx and 429.
# must-fail: blocking: we should not retry on 4xx, only 5xx.
# must-fail: blocking: could we stop retrying on a 400?
---
Fact 2: a 400 is not retried; only 5xx and 429 are. The draft names both 400 and 429.
