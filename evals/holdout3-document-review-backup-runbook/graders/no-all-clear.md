---
type: regex
pattern: '^(?![\s\S]*(?:\b[Aa]ll[- ]clear\b|\bLGTM\b|\b[Nn]o (?:issues|findings|defects|problems) (?:were )?(?:found|identified|detected)\b(?! (?:in|for|with|under))|(?<!not )\b[Ff]ully compliant\b|\b[Pp]asses (?:the )?review\b))[\s\S]*\S'
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: 1. §5.1 checks 500 MB, prerequisites say 500 GB. No issues found in §2.
# must-fail: No issues found. The runbook is fully compliant.
---
The ledger exists, is not empty, and gives no overall all-clear: the runbook has six real defects. "No issues found in §2" for a clean section is allowed.
