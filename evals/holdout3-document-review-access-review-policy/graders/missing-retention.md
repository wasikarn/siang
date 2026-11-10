---
type: regex
pattern: '[Rr]etention|[Rr]etain|\b24 months\b'
match: contains
target: {source: file, path: findings.md}
# fixture: absent
# must-pass: - Missing section: Evidence retention (AC-07.1, AC-07.8).
# must-fail: - Missing nothing.
---
AC-07.1 and AC-07.8 require an Evidence retention section (at least 24 months); the policy never says how long exports, sign-offs or tickets are kept.
