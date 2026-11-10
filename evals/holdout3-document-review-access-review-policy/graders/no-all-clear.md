---
type: regex
pattern: '^(?![\s\S]*(?:\b[Aa]ll[- ]clear\b|\bLGTM\b|\b[Nn]o (?:issues|findings|defects|problems|gaps) (?:were )?(?:found|identified|detected)\b(?! (?:in|for|with|under))|(?<!not )\b[Ff]ully compliant\b|\b[Rr]eady for (?:the )?audit\b))[\s\S]*\S'
match: contains
target: {source: file, path: findings.md}
# fixture: absent
# must-pass: 1. §6 table says 45 hours, §4 says 45 days. No issues found in §3.
# must-fail: No findings identified. The policy is fully compliant and ready for audit.
---
The ledger exists, is not empty, and gives no overall all-clear: the policy has six real defects. "No issues found in §3" for a clean section is allowed.
