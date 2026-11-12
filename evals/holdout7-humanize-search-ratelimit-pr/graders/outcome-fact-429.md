---
type: regex
pattern: '^(?=[\s\S]*\b429\b[^\n]*Retry-After|[\s\S]*Retry-After[^\n]*\b429\b)'
match: contains
target: {source: file, path: PR_DESCRIPTION.md}
# must-pass: Over the limit you get a 429 with a `Retry-After` header in seconds.
# must-fail: Over the limit you get a 429 and should back off.
# must-fail: Over the limit you get a 503 with a `Retry-After` header.
---
The over-limit response stays: HTTP 429 together with the `Retry-After` header, on the same line.
