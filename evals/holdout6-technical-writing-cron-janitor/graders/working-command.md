---
type: regex
pattern: '^(?=[\s\S]*\bJANITOR_ROOT=\S)[\s\S]*janitor\.py(?![^\n]*--path)[^\n]*--dry-run'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: JANITOR_ROOT=/srv/uploads python3 /opt/janitor/janitor.py --dry-run
# must-pass: export JANITOR_ROOT=demo; ./janitor.py --dry-run
# must-fail: python3 /opt/janitor/janitor.py --path /srv/uploads --dry-run
# must-fail: JANITOR_ROOT=demo python3 janitor.py --path demo --dry-run
---
A dry-run command that works: JANITOR_ROOT is set and `--path` is not passed. The old README's `--path ... --dry-run` exits 2.
