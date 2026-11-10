---
type: regex
pattern: '\b10\s*min|\b[Tt]en minutes|[Ll]ast restore test'
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: - §1 claims restores take under 10 minutes with no dated test or ticket.
# must-fail: - §1 purpose is clear.
---
Section 1 claims the procedure restores any database in under 10 minutes, and "Last restore test" gives no date or ticket (standard rule 6), so the claim cannot be checked.
