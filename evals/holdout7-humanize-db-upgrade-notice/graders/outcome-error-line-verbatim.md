---
type: regex
pattern: 'ERROR: cannot execute INSERT in a read-only transaction(?![^\s`])'
match: contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: > ERROR: cannot execute INSERT in a read-only transaction
# must-pass: `ERROR: cannot execute INSERT in a read-only transaction`
# must-fail: ERROR: cannot execute INSERT in a read-only transaction.
# must-fail: error: cannot execute INSERT in a read-only transaction
# must-fail: ERROR: ไม่สามารถ INSERT ใน read-only transaction ได้
---
The log line engineers will grep for stays exact: no translation, no case change, no trailing punctuation glued to it.
