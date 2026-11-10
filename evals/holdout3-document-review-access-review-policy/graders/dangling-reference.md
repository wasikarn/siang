---
type: regex
pattern: '(?:[Ss]ection|§|[Ss]ec\.?)\s*11\b'
match: contains
target: {source: file, path: findings.md}
# fixture: absent
# must-pass: | §8 | Refers to section 11, but the policy ends at §9 | AC-07.6 |
# must-fail: | §8 | exceptions capped at 90 days |
---
Section 8 sends disputed exceptions to section 11; the policy has nine sections (AC-07.6).
