---
type: regex
pattern: '--dead-dir\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: --dead-dir DIR  where undeliverable events are moved (default: spool/dead)
# must-pass: RELAY_URL=$URL RELAY_SECRET=$SECRET python3 relay.py --dead-dir /var/lib/relay/dead
# must-fail: Failed events are moved to spool/dead.
# must-fail: --dead-letter DIR  where failed events go
---
`--dead-dir DIR` exists only in the code (and `--help`); the old README never mentions it.
