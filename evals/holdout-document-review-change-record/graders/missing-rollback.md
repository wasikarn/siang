---
type: regex
pattern: 'roll[ -]?back[^\n]*(?:missing|absent|omit|lack|not (?:present|included|found)|no )|(?:missing|absent|omit|lack|not (?:present|included|found)|no )[^\n]*roll[ -]?back'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: the standard requires section 4 Rollback plan, and the record skips from 3 to 5.
