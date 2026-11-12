---
type: regex
pattern: '^(?![\s\S]*(?:let (?:me|us) know|reach out|feel free|any questions|questions\?|thanks for (?:your )?(?:patience|understanding)|happy to help))[\s\S]+'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: If the switchover fails we stay on Postgres 15 and try again next Thursday.
# must-fail: Let me know if you have any questions.
# must-fail: Thanks for your patience.
# must-fail: Feel free to reach out in #db-ops.
---
No sample closes with an offer of help or thanks, and the user listed none: the draft adds no such closer.
