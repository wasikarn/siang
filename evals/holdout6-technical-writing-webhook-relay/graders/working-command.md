---
type: regex
pattern: '^(?=[\s\S]*\bRELAY_URL=\S)(?=[\s\S]*\bRELAY_SECRET=\S)[\s\S]*relay\.py(?![^\n]*--insecure)[^\n]*--dry-run'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: RELAY_URL=http://127.0.0.1:9/ RELAY_SECRET=test-secret python3 relay.py --dry-run
# must-pass: export RELAY_URL=https://hooks.example.com/in RELAY_SECRET=$SECRET; python3 relay.py --dry-run
# must-fail: RELAY_URL=https://staging-hooks.example.com/in python3 relay.py --insecure --dry-run
# must-fail: RELAY_URL=https://hooks.example.com/in python3 relay.py --dry-run
---
A dry-run command that works: both RELAY_URL and RELAY_SECRET are set and `--insecure` is not passed. The old README's command exits 2 (--insecure) and then 78 (no secret).
