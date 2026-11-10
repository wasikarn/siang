---
type: regex
pattern: '^(?=[\s\S]*48,?250)[\s\S]*(?:March 14,? 2026|14 March,? 2026|2026-03-14|14/03/2026|03/14/2026)'
match: contains
target: {source: file, path: draft.md}
# must-pass: a variance of $48,250; the ledger is due on 2026-03-14.
# must-pass: a variance of $48250, due 14 March 2026.
# must-fail: a variance of about $48,000, due in mid-March.
---
The amount ($48,250) and the due date (March 14, 2026, in any common full-date form) survive the rewrite.
