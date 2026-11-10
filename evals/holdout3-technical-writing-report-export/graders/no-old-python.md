---
type: regex
pattern: '\b3\.(?:[0-9]|10)\b(?:\+| or (?:newer|later|above|higher))'
match: not_contains
target: {source: file, path: docs/exporting.md}
# must-pass: Python 3.11 or newer. On 3.10 or older the script exits with an error.
# must-fail: Requires Python 3.8 or newer.
---
The minimum is 3.11, so no older version may be given as the minimum ("3.8 or newer", "3.9+").
