---
type: regex
pattern: '(?:\b5\.3\b)[\s\S]{0,200}(?:(?:skip|jump|gap|missing|absent|out of sequence|not in sequence|sequence|numbering|no section|does not exist|doesn.t exist|there is no|omitted))|(?:(?:skip|jump|gap|missing|absent|out of sequence|not in sequence|sequence|numbering|no section|does not exist|doesn.t exist|there is no|omitted))[\s\S]{0,200}(?:\b5\.3\b)|\b5\.2\b[^\n]{0,40}\b5\.4\b'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: Heading numbering skips 5.3: section 5 goes from 5.2 Application health to 5.4 Backups.
# must-pass: | F2 | 5.4 | Subsection 5.3 is missing; numbering is not in sequence. |
# must-fail: Section 5.4 Backups confirms the next base backup will run.
# must-fail: Section numbering is otherwise in sequence.
---
Section 5 runs 5.1, 5.2, 5.4 with no 5.3 (standard req 5).
