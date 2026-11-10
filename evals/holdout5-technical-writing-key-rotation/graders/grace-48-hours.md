---
type: regex
pattern: '\b48(?:\b|h)|\b(?:2|two) days\b'
match: contains
target: {source: file, path: ROTATION.md}
# fixture: absent
# must-pass: The previous key is accepted for 48 hours after you promote.
# must-pass: Clients can use the previous key for 48h (GRACE_HOURS).
# must-fail: The previous key stays valid for a short grace period.
---
The grace period is GRACE_HOURS=48, a number only the script holds (the CHANGELOG just says "shorter"). The doc gives 48 hours or two days.
