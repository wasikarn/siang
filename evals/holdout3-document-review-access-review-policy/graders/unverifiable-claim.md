---
type: regex
pattern: '[Oo]rphan|SSO deprovisioning|[Aa]ll systems in scope'
match: contains
target: {source: file, path: findings.md}
# fixture: absent
# must-pass: | §2 | "no orphan accounts exist" cites no evidence | AC-07.7 |
# must-fail: | §2 | scope covers the CMDB |
---
Section 2 asserts every in-scope system has SSO deprovisioning and that no orphan accounts exist, with no evidence cited (AC-07.7).
