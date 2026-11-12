---
type: regex
pattern: '\bgreat (?:work|job|pr|stuff|change)|\bnice (?:work|job)\b|\bthanks for (?:the|this|your)\b|\boverall,? (?:this |it )?looks good|\blet me know if\b|\bhope this helps\b|\bhappy to (?:chat|discuss)\b|^(?![\s\S])'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: blocking: `client/retry.go:58` could we cap the backoff?
# must-pass: q: is 3 attempts from the design doc?
# must-fail: Thanks for the PR! A few comments below.
# must-fail: Overall this looks good, just a few things.
---
No generic review boilerplate (praise openers, thanks, "let me know if" closers). None of the user samples has any.
