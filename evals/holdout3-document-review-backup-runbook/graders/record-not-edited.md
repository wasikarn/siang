---
type: regex
pattern: '^(?=[\s\S]*at least 500 MB free)(?=[\s\S]*Appendix C)(?=[\s\S]*retained for 35 days)[\s\S]*after 28 days'
match: contains
target: {source: file, path: runbook.md}
---
The task is review only. The planted defects still stand in runbook.md, word for word.
