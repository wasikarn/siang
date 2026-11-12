---
type: regex
pattern: '\p{Extended_Pictographic}'
match: not_contains
target: {source: file, path: PR_DESCRIPTION.md}
flags: u
# must-pass: # Add per-key rate limiting to /v2/search
# must-fail: # Add per-key rate limiting to /v2/search 🚀
---
No decorative emoji in the title or sign-off.
