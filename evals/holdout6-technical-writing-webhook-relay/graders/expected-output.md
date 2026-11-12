---
type: regex
pattern: 'relay: \d+ event\(s\) ready, 0 sent \(dry run\)'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: relay: 3 event(s) ready, 0 sent (dry run)
# must-pass:     relay: 41 event(s) ready, 0 sent (dry run)
# must-fail: would POST 3 events
# must-fail: relay: 3 events ready (dry run)
---
The dry-run summary line in the real format (`relay: 3 event(s) ready, 0 sent (dry run)` on the shipped spool).
