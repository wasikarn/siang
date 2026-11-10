---
type: regex
pattern: '!|^[ \t]*[-*•][ \t]'
match: not_contains
target: {source: file, path: draft.md}
flags: m
# must-pass: The review is complete; the variance is open.
# must-fail: Great progress!
# must-fail: - Daniel Okafor has completed the review.
---
Marta writes flat prose paragraphs with no exclamation marks and no bullet lists; the draft has both.
