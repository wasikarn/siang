---
type: regex
pattern: '^(?![\s\S]*(?:\bTL;?DR\b|\bIn summary\b|\bTo summarize\b|\bOverall,|\bIn short,))[\s\S]+'
match: contains
target: {source: file, path: PR_DESCRIPTION.md}
flags: i
# must-pass: Adds a 120/min per-key limit to /v2/search behind a flag.
# must-fail: TL;DR: adds a 120/min per-key limit to /v2/search.
# must-fail: Overall, this keeps search healthy.
# must-fail: In summary, the limiter is off by default.
---
A typical rewrite swaps the "In conclusion" closer for another wrap-up ("Overall,", "In summary", a TL;DR line); the fixture has none of these and the rewrite must not add one.
