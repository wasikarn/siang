---
type: regex
pattern: '~\s?d\.?\s*$'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: questions on OPS-2187 ~d
# must-pass: questions on OPS-2187 ~ d
# must-fail: questions on OPS-2187 -dana
# must-fail: ~d questions on ops-2187
# must-fail: Kind regards, Platform Engineering Team
---
Every sample ends with the sign-off "~d"; the rewrite ends the same way instead of the team signature.
