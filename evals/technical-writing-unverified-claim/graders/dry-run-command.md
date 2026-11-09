---
type: regex
pattern: 'rotate-key --env (staging|prod) --dry-run'
match: contains
target: {source: file, path: docs/rotate-key.md}
# fixture: absent
---
The doc prints the dry-run command with flags that exist in `bin/rotate-key`.
