---
type: regex
pattern: 'relay\.py[^\n]*--insecure\b|^[ \t]*(?:[-*]|\|)[ \t]*`?--insecure\b'
match: not_contains
target: {source: file, path: README.md}
flags: m
# must-pass: There is no `--insecure` flag any more; passing it exits 2.
# must-pass: RELAY_URL=$URL RELAY_SECRET=$SECRET python3 relay.py --dry-run
# must-fail: RELAY_URL=https://staging-hooks.example.com/in python3 relay.py --insecure --dry-run
# must-fail: - `--insecure`: skip TLS certificate checks (for staging receivers)
---
`--insecure` was removed (argparse rejects it with exit 2). The doc must not show it in a command or an options list; a note that it is gone is fine.
