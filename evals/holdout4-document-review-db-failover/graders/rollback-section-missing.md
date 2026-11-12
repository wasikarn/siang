---
type: regex
pattern: 'roll[- ]?back[\s\S]{0,80}(?:missing|absent|lacks|lacking|not present|not included|omitted|no section|not found|none|not met|unmet|does not (?:have|include|contain|exist)|doesn.t (?:have|include|contain|exist))|(?:missing|absent|lacks|lacking|omits|without|no|has no|does not (?:have|include|contain)|doesn.t (?:have|include|contain))\s+(?:an?\s+|the\s+|any\s+|required\s+|dedicated\s+)*roll[- ]?back'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: No Rollback section: requirement 8 is unmet.
# must-pass: | F7 | whole doc | Rollback section is missing (standard req 8). |
# must-fail: The Rollback section covers how to undo a failed promotion.
# must-fail: Section 5.3 is missing.
---
The standard requires a Rollback section; the runbook has none (standard req 8).
