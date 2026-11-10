---
type: regex
pattern: '\b35\b[^\n]*\b28\b|\b28\b[^\n]*\b35\b'
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: | §1 vs §4 | retention 35 days in Purpose, 28 days in the pgbackrest expiry | rule 7 |
# must-fail: | §1 | retention stated |
---
Section 1 retains base backups 35 days; section 4 expires them after 28 days. The finding puts both numbers on one line (a table row or a sentence).
