---
type: regex
pattern: '^[ \t]*\d+[.)][ \t][\s\S]{0,300}?--dry-run[\s\S]{0,600}?relay: \d+ event\(s\) ready, 0 sent \(dry run\)'
match: contains
target: {source: file, path: README.md}
flags: m
# fixture: absent
# must-pass: 1. Run `RELAY_URL=$URL RELAY_SECRET=$SECRET python3 relay.py --dry-run`. Expected last line: `relay: 3 event(s) ready, 0 sent (dry run)`
# must-pass: 2) Dry run with --dry-run; it ends with relay: 3 event(s) ready, 0 sent (dry run)
# must-fail: 1. Run `RELAY_URL=$URL RELAY_SECRET=$SECRET python3 relay.py --dry-run`.
# must-fail: Run the dry run; you should see relay: 3 event(s) ready, 0 sent (dry run)
---
A numbered step that runs the dry run (which exits 78 if an env var is missing) is followed by the output the reader should see.
