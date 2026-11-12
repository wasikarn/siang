---
type: regex
pattern: '\bJANITOR_ROOT\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: export JANITOR_ROOT=/srv/uploads
# must-pass: | `JANITOR_ROOT` | yes | Directory to clean. |
# must-fail: python3 janitor.py --path /srv/uploads
# must-fail: Set JANITOR_DIR to the upload directory.
---
The directory to clean comes from the JANITOR_ROOT environment variable, required (unset exits 3); the old README never names it.
