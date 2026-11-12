---
type: regex
pattern: 'In today''s|worth noting|\bNot only\b|In conclusion|ongoing commitment'
match: not_contains
target: {source: file, path: PR_DESCRIPTION.md}
flags: i
# must-pass: Search p99 hit 4.8 s in the 2026-11-03 incident.
# must-fail: In today's fast-paced API landscape, we need limits.
# must-fail: It is worth noting that p99 hit 4.8 s.
# must-fail: It not only protects search but also helps clients.
# must-fail: In conclusion, this improves reliability.
---
Stock frames go: the "In today's..." opener, "worth noting", "Not only... but also", and the "In conclusion... ongoing commitment" sign-off.
