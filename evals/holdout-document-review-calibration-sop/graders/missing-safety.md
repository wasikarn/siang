---
type: regex
pattern: 'safety[^\n]*(?:missing|absent|omit|lack|not (?:present|included|found)|no )|(?:missing|absent|omit|lack|not (?:present|included|found)|no )[^\n]*safety'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: the standard requires section 4 Safety, and the record skips from 3 to 5.
