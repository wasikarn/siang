---
type: regex
pattern: '^(?=[\s\S]*\bjq\b)[\s\S]*\bopenssl\b'
match: contains
target: {source: file, path: ROTATION.md}
# fixture: absent
# must-pass: Prerequisites: `openssl` and `jq` on PATH.
# must-fail: Prerequisites: none.
---
The script exits unless both openssl and jq are installed; only the script says so. The doc names both.
