---
type: regex
pattern: '\b4\.2\b[\s\S]{0,200}(?:\bstep 5\b|\bno 5\b|(?:skip|jump|gap|missing|sequence|numbering)[\s\S]{0,40}\b5\b|\b5\b[\s\S]{0,30}(?:skip|missing|absent|omitted)|\b4\W{1,8}6\b|from 4 to 6)|(?:\bstep 5\b|from 4 to 6|\b4 to 6\b)[\s\S]{0,200}\b4\.2\b'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: Section 4.2 steps jump from 4 to 6; step 5 is missing.
# must-pass: | F2 | 4.2 | Numbered list skips 5 (1, 2, 3, 4, 6, 7). |
# must-fail: Section 4.2 has the contract approval steps in order.
# must-fail: Step 5 of section 3.2 forwards Tier 1 requests to security.
---
The 4.2 contract-approval list runs 1, 2, 3, 4, 6, 7 with no step 5 (standard req 5).
