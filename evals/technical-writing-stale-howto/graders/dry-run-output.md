---
type: regex
pattern: 'dry-run: would rotate (staging|prod) key'
match: contains
target: {source: file, path: docs/rotate-key.md}
# fixture: absent
---
The doc shows the real output of the dry run, which only a run or a read of the source supplies (step 3).
