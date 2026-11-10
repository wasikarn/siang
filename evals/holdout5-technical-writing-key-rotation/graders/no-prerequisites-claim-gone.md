---
type: regex
pattern: '\b[Nn]o prerequisites\b|handles everything'
match: not_contains
target: {source: file, path: ROTATION.md}
# must-pass: ## Prerequisites
# must-pass: You need openssl, jq and KEYSTORE_DIR set; there are no other prerequisites.
# must-fail: No prerequisites: the script handles everything.
---
The stale claim that nothing is needed beforehand is gone.
