---
type: regex
pattern: '\bwrites?\b[\s\S]{0,100}\b(?:10|ten)[\s-]?(?:min|mins|minutes?)\b|\b(?:10|ten)[\s-]?(?:min|mins|minutes?)\b[\s\S]{0,100}\bwrites?\b'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: Writes to orders fail for up to 10 minutes during the switchover.
# must-pass: Expect up to ten minutes of failed writes.
# must-fail: Writes to orders fail for a short time during the switchover.
# must-pass: Expect a 10-minute window where writes to orders fail.
---
Writes to orders fail for up to 10 minutes during the switchover.
