---
type: regex
pattern: '(?<!not |n.t )\b(?:use|in|follow)s? (?:your |the )?(?:machine.s |system |computer.s )?local time ?zone'
flags: i
match: not_contains
target: {source: file, path: SETUP.md}
# must-pass: Times are in UTC and do not use your local time zone unless you set `timezone`.
# must-fail: Report times use your local time zone.
# must-fail: Times are in the system local timezone.
---
Stale claim: the default is UTC, not the machine's local time zone.
