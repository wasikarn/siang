---
type: regex
pattern: '\b(?:12|18)\b'
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: Summary says 12 web-tier hosts, step 6 says all 18; either number names the conflict.
