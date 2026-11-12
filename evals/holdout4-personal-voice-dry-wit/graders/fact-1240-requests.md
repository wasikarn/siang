---
type: regex
pattern: '(?<![\d,.])1[,.\s]?240(?!\d)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: 1,240 checkout requests failed.
# must-pass: 1240 requests failed.
# must-fail: About 1,200 requests failed.
# must-fail: 12,400 requests failed.
---
The failed-request count (1,240) survives, with or without the comma.
