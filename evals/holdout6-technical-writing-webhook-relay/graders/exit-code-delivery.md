---
type: regex
pattern: 'exit(?:s|ed)?(?: with)?(?: code| status)?[^\n]{0,40}\b6\b[^\n]{0,80}(?:fail|deliver|dead|unreachable)|(?:fail|deliver|dead|unreachable)[^\n]{0,100}(?:exit|status|code|return)[^\n]{0,30}\b6\b|^[ \t]*(?:[-*][ \t]*)?\|?[ \t]*`?6`?[ \t]*[|:][^\n]*(?:fail|deliver|dead|unreachable)'
match: contains
target: {source: file, path: README.md}
flags: im
# fixture: absent
# must-pass: | `6` | At least one event failed after all retries and was moved to `spool/dead/`. |
# must-pass: If any event cannot be delivered, relay.py exits with status 6.
# must-fail: Exit status is 0 on success and 1 if any event could not be delivered.
# must-fail: | `1` | delivery failed |
---
A failed delivery exits 6 (`EXIT_DELIVERY_FAILED`, seen on a run against a closed port); the old README says 1.
