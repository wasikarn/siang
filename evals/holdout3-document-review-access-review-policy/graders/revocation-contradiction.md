---
type: regex
pattern: '\b48\b[^\n]*\b72\b|\b72\b[^\n]*\b48\b'
match: contains
target: {source: file, path: findings.md}
# fixture: absent
# must-pass: | §5 vs Step 6 | Revocation is 48 hours in §5 but 72 hours in Step 6 | AC-07.4 |
# must-fail: | Step 6 | revocation deadline stated |
---
Section 5 revokes within 48 hours of sign-off; step 6 allows 72 hours. AC-07.4 wants one deadline used everywhere. The finding puts both numbers on one line.
