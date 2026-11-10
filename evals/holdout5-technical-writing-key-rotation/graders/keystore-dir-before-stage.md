---
type: regex
pattern: 'KEYSTORE_DIR[\s\S]*?rotate-key\.sh\s+--stage'
match: contains
target: {source: file, path: ROTATION.md}
# fixture: absent
# must-pass: export KEYSTORE_DIR=/srv/signer/keys, then run ./rotate-key.sh --stage
# must-fail: Run ./rotate-key.sh --stage. Keys live in ./keys.
---
The script stops unless KEYSTORE_DIR is set (2.0 dropped the ./keys default). The doc mentions KEYSTORE_DIR before the first stage command.
