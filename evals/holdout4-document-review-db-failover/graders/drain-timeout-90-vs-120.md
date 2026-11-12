---
type: regex
pattern: '(?:\b90\s*(?:s\b|secs?\b|seconds?\b)|\b1\.5\s*min)[\s\S]{0,300}(?:\b120\s*(?:s\b|secs?\b|seconds?\b)|\b(?:2|two)\s*min)|(?:\b120\s*(?:s\b|secs?\b|seconds?\b)|\b(?:2|two)\s*min)[\s\S]{0,300}(?:\b90\s*(?:s\b|secs?\b|seconds?\b)|\b1\.5\s*min)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: Drain timeout conflicts: 90 seconds in 2.3 but 120 seconds in section 7 step 2.
# must-pass: | F3 | 7 step 2 | Says pgbouncer waits up to `120 s`; 2.3 says `90 s`. Inconsistent. |
# must-fail: pgbouncer connection drain timeout is 90 seconds.
# must-fail: Section 7 waits 120 seconds for the drain.
---
The pgbouncer drain timeout is 90 seconds in 2.3 and 120 seconds in section 7 step 2 (standard req 6).
