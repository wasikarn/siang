---
type: regex
pattern: 'retry\.ts|computeDelay|retryCharge'
match: contains
target: {source: file, path: PR.md}
# fixture: absent
# must-pass: Only src/payments/retry.ts changes.
# must-pass: Look at computeDelay() and retryCharge().
# must-fail: Small change to the payment retry logic.
---
The draft tells the reviewer where to look (the file or the two functions), which makes a fast review possible.
