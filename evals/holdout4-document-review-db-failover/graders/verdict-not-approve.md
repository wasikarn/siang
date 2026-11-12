---
type: regex
pattern: 'verdict[\s\S]{0,40}?(?:approved?[- _,]+with[- _]+changes|reject(?:ed)?\b)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: **Verdict:** approve-with-changes
# must-pass: Verdict: reject (8 findings, 2 blocking)
# must-fail: Verdict: approve
# must-fail: **Verdict:** approved, no findings
---
The document breaks the standard in several places, so the verdict is approve-with-changes or reject, never a plain approve.
