---
type: regex
pattern: '[Rr]ollback[^\n]*(?:[Mm]issing|absent|\b[Nn]o\b|[Ll]ack|omit|not (?:present|included|found|provided))|(?:[Mm]issing|absent|\b[Nn]o\b|[Ll]ack|[Oo]mit)[^\n]*[Rr]oll[- ]?back|[Bb]ack[- ]?out'
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: - Missing section: Rollback (required by rule 1).
# must-pass: | whole doc | The Rollback section is absent | rule 1 |
# must-fail: - Rollback is covered.
---
Standard rule 1 requires a Rollback section between Verification and Escalation; the runbook has none.
