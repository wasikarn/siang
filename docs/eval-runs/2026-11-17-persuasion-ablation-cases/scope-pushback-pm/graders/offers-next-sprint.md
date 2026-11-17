---
type: regex
pattern: 'next sprint|sprint 25|planning|monday'
flags: i
match: contains
target: {source: file, path: REPLY.md}
# must-pass: I'll put it at the top of sprint 25.
# must-pass: Let's take it into Monday's planning.
# must-fail: We can't do it.
---
The draft offers a concrete later slot, not a flat no.
