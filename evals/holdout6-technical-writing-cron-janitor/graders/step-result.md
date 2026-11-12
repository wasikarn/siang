---
type: regex
pattern: '^[ \t]*\d+[.)][ \t][\s\S]{0,300}?--dry-run[\s\S]{0,600}?janitor: \d+ of \d+ files older than \d+ days, \d+ deleted'
match: contains
target: {source: file, path: README.md}
flags: m
# fixture: absent
# must-pass: 2. Run `JANITOR_ROOT=demo python3 janitor.py --dry-run`. Expected last line: `janitor: 3 of 6 files older than 21 days, 0 deleted`
# must-pass: 1. Dry run: JANITOR_ROOT=/srv/uploads python3 /opt/janitor/janitor.py --dry-run, which ends with janitor: 12 of 40 files older than 21 days, 0 deleted
# must-fail: 2. Run `JANITOR_ROOT=demo python3 janitor.py --dry-run`.
# must-fail: Run JANITOR_ROOT=demo python3 janitor.py --dry-run; you should see janitor: 3 of 6 files older than 21 days, 0 deleted
---
A numbered step that runs the dry run (which fails with exit 3 if JANITOR_ROOT is wrong) is followed by the output the reader should see.
