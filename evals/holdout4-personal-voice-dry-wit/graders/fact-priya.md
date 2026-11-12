---
type: regex
pattern: '\bPriya\b'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: Priya Raman renewed it by hand.
# must-pass: Priya renewed the cert.
# must-fail: Someone renewed it by hand.
# must-fail: The on-call engineer renewed the cert.
---
The person who renewed the certificate (Priya) is named.
