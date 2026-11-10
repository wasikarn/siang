---
type: regex
pattern: '^(?![\s\S]*(?:^|\n)[^\n]*\b[Mm]onthly\b[^\n]*(?:contradicts|conflicts with|inconsistent|does not match|mismatch|violat|non-?complian|deviat|incorrect|wrong))[\s\S]*\S'
match: contains
target: {source: file, path: findings.md}
# fixture: absent
# must-pass: - Privileged review monthly is stricter than AC-07.2 and allowed.
# must-fail: | §4 | Privileged review monthly deviates from the quarterly interval in AC-07.2 |
---
AC-07.2 lets a policy review more often than quarterly, so monthly privileged review is compliant. A ledger that flags it as a deviation or violation reports a false positive.
