---
type: regex
pattern: '--dry-run(?![\w-])'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: python3 logtidy.py --dir /var/log/myapp --dry-run
---
`--dry-run` prints what would be deleted and deletes nothing: the safe first step the prompt asks for, missing from the stale README.
