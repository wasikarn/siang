---
type: regex
pattern: '\bkindly\b|do(?:n.t| not) hesitate|best regards|around the clock|rest assured|^\s*$'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: Priya renewed it by hand.
# must-pass: Ask Priya if you need the cert details.
# must-fail: Kindly note the cert has been renewed.
# must-fail: Rest assured this will not happen again.
---
Sample 06 is CertPoint's email, labelled as not the user's. Its formulas are not the user's voice.
