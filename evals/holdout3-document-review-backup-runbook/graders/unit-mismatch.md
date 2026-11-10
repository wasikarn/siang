---
type: regex
pattern: '500\s*MB|\bMB\b[^\n]*\bGB\b|\bGB\b[^\n]*\bMB\b'
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: | 5.1 | Says 500 MB free, but Prerequisites say 500 GB | rule 5 |
# must-fail: | 5.1 | free space check is fine |
---
Prerequisites ask for 500 GB free on /backup; step 5.1 checks for 500 MB. A report that names the 500 MB check or puts MB beside GB on one line caught the unit mismatch.
