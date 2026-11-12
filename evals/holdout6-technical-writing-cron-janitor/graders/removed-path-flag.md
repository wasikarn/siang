---
type: regex
pattern: 'janitor\.py[^\n]*--path\b|^[ \t]*(?:[-*]|\|)[ \t]*`?--path\b'
match: not_contains
target: {source: file, path: README.md}
flags: m
# must-pass: The old `--path` flag is gone; set JANITOR_ROOT instead (passing `--path` exits 2).
# must-pass: JANITOR_ROOT=/srv/uploads python3 janitor.py --dry-run
# must-fail: python3 janitor.py --path /srv/uploads --dry-run
# must-fail: - `--path DIR`: directory to clean (required)
---
`--path` was removed (argparse rejects it with exit 2; the directory now comes from JANITOR_ROOT). The doc must not show it in a command or an options list; a note that it is gone is fine.
