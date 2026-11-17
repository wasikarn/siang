---
type: regex
pattern: 'payments\.retry_v2'
match: contains
target: {source: file, path: PR.md}
# fixture: absent
# must-pass: Behind `payments.retry_v2` (default off).
# must-fail: Behind a feature flag (default off).
---
The draft names the flag that keeps the change off by default, so the reviewer can check the safety claim.
