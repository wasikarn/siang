---
type: regex
pattern: 'owner\w*[\s\S]{0,80}(?:missing|absent|not (?:named|stated|listed|given|specified|identified|assigned|defined)|unnamed|unassigned|lacks|lacking|none|not met|unmet)|(?:missing|absent|lacks|lacking|without|names no|has no|no)\s+(?:an?\s+|named\s+|accountable\s+|document\s+|designated\s+)*owner'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: Header has no accountable owner (standard req 1).
# must-pass: | F7 | header | Owner missing |
# must-fail: Owner: Procurement Operations manager.
# must-fail: Each section names the role that performs it.
---
The header has a version and dates but names no accountable owner (standard req 1).
