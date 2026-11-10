---
type: regex
pattern: '[Aa]ppendix\s*C\b'
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: §7 points to Appendix C, which does not exist.
# must-fail: §7 escalation looks fine.
---
Section 7 sends the reader to Appendix C for contacts; the runbook has no appendix at all (standard rule 4).
