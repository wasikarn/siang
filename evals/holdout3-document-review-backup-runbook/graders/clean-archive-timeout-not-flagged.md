---
type: regex
pattern: '^(?![\s\S]*(?:^|\n)[^\n]*(?:archive_timeout|\b60\s*s\b)[^\n]*(?:contradicts|conflicts with|inconsistent|does not match|mismatch|incorrect|wrong|violat|exceeds))[\s\S]*\S'
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: - §4 archive_timeout = 60s supports the 15 minute RPO; no problem.
# must-fail: - §4 archive_timeout 60s is inconsistent with RPO 15 minutes.
---
archive_timeout = 60s is well inside the 15-minute RPO and is not a unit clash: a ledger that flags it as a mismatch or violation reports a false positive.
