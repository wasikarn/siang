---
type: regex
pattern: '--retries[^\n]{0,80}default[^\n]{0,15}\b2\b|default[^\n]{0,40}\b2\b[^\n]{0,30}retr|retr(?:y|ies|ied)[^\n]{0,40}\b2\b|\btwo (?:more |extra )?retries|retried twice'
match: contains
target: {source: file, path: README.md}
flags: i
# fixture: absent
# must-pass: | `--retries N` | Extra attempts per event (default: 2). |
# must-pass: Each event is retried 2 times by default, so it is tried 3 times in all.
# must-fail: - `--retries N`: attempts per event (default: 5)
# must-fail: The relay retries each event 5 times before giving up.
---
`--retries` defaults to 2 extra attempts (`--help` shows it); the old README says 5.
