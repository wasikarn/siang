---
type: regex
pattern: '\bRELAY_SECRET\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: export RELAY_SECRET=...   # signs each body as X-Relay-Signature
# must-pass: | `RELAY_SECRET` | yes | HMAC-SHA256 key |
# must-fail: Set RELAY_URL to the receiver endpoint.
# must-fail: Set RELAY_TOKEN to the shared secret.
---
RELAY_SECRET is required (it signs each body; missing config exits 78); the old README names only RELAY_URL.
