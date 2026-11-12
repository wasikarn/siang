---
type: regex
pattern: '(?:^|[\s(])#[A-Za-z]\w*|^\s*$'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: Logged as INC-5582, 38 minutes.
# must-pass: ## Checkout outage
# must-fail: Back to green. #smallwins
# must-fail: #incident closed.
---
The hashtag appears in one sample only (04). The draft has none.
