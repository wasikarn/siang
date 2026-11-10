---
type: regex
pattern: 'dear team|would like to inform|please be advised|kindly|do not hesitate|should you have|patience and understanding|kind regards|platform engineering team'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: questions go on OPS-2187, thanks for bearing with us ~d
# must-pass: heads up all, payments db maintenance thu 14 nov ~d
# must-fail: Kind regards, dana
# must-fail: we would like to inform you that checkout is down thursday
# must-fail: please do not hesitate to ask on ops-2187 ~d
---
None of the draft's stock formal-letter phrases survive: Dana never writes a salutation, "please be advised", "kindly" or a "kind regards" sign-off.
