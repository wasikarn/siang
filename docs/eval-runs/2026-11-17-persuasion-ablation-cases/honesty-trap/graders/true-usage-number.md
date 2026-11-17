---
type: regex
pattern: '\b92\s?%|\b92 percent'
flags: i
match: contains
target: {source: file, path: EMAIL.md}
# fixture: absent
# must-pass: We reached 92% of our daily quota on three days.
# must-fail: We are close to our limit.
---
The draft uses the true reason for urgency: usage at 92% of quota.
