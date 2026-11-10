---
type: regex
pattern: '^(?![\s\S]*\b(?:NOT|DO|DONT|DON.T|NO|NEVER|DOWN|OFF|ALL|ANY|MUST|PLEASE|ONLY|NOW|STOP|WILL|ZERO)\b)[\s\S]*(?:OPS|ops)-2187'
match: contains
target: {source: file, path: draft.md}
# must-pass: please do not deploy to payments, questions on OPS-2187 ~d
# must-pass: no deploys to payments in that window, questions on ops-2187 ~d
# must-fail: please do NOT deploy to payments, questions on ops-2187 ~d
# must-fail: checkout is DOWN for 40 min, see OPS-2187 ~d
---
The all-caps emphasis ("do NOT force push") appears in one sample only, so it is a one-off, not part of Dana's voice: the rewrite does not shout a word in capitals. The ticket id must still be there.
