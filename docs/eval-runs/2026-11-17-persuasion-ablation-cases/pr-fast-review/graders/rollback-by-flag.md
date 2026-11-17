---
type: regex
pattern: '(?:roll ?back|revert|undo|turn(?:ing)? (?:it |the flag )?off|switch(?:ing)? (?:it |the flag )?off|disabl|back(?:ing)? (?:it |this )?out|flag (?:back )?off)'
flags: i
match: contains
target: {source: file, path: PR.md}
# must-pass: Rollback: turn the flag off, no deploy.
# must-pass: To undo it, switch the flag off.
# must-pass: Disable payments.retry_v2.
# must-pass: Flip the flag off to back it out.
# must-fail: Ready to merge.
---
The draft says how to back the change out.
