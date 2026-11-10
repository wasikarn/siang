---
type: regex
pattern: '--keep-days(?![\w-])'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: python3 logtidy.py --dir /var/log/myapp --keep-days=7
# must-fail: python3 logtidy.py --dir /var/log/myapp --older-than 30
---
The README names the current retention flag, `--keep-days` (either `--keep-days N` or `--keep-days=N`).
