---
type: regex
pattern: '^(?:(?!report\.py[ \t]+--)[\s\S])*?\b3\.1[1-9]\b'
match: contains
target: {source: file, path: docs/exporting.md}
# fixture: absent
# must-pass: You need Python 3.11 or newer.    python3 report.py --since 2026-10-01
# must-fail:     python3 report.py --since 2026-10-01    Needs Python 3.11+.
---
report.py exits on Python below 3.11 (it imports tomllib), so the how-to must state Python 3.11+ before the first command that runs it.
