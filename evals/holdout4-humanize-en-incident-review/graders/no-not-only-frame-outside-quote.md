---
type: regex
pattern: '^(?!\s*>).*\bnot (?:just|only|merely)\b[^.\n]{0,80}\bbut\b'
flags: im
match: not_contains
target: {source: file, path: INCIDENT-2291.md}
# must-pass: > "This is not just a defaults change but a behavior change for every long-lived pool."
# must-pass: The config was wrong, and our review process let it through.
# must-fail: The failure was not only a configuration issue but a gap in how we review dependency upgrades.
# must-fail: This was not merely a bad default but a review gap.
---
The "not only X but Y" frame in the author's own prose goes. The same frame inside the blockquote is a genuine quote from the poolkit release notes and must not trip this grader (lines starting with > are skipped).
