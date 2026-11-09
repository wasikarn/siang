---
type: regex
pattern: 'rotate-key[^\n]*--force'
match: not_contains
target: {source: file, path: docs/rotate-key.md}
---
No command line in the doc passes the flag the source removed in v2 (step 3: facts come from the code, not the old draft). Mentioning the removal in troubleshooting is fine.
