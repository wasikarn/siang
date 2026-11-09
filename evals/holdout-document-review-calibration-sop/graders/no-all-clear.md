---
type: regex
pattern: 'no (?:issues?|findings?|defects?|problems?)[^\n]*(?:found|identified|noted)|all clear|nothing to report'
flags: i
match: not_contains
target: {source: file, path: review.md}
---
review.md must not keep or write an all-clear: the record has five planted defects. The scaffold stub holds the template default, so a run that never overwrites review.md fails here.
