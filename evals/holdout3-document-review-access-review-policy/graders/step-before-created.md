---
type: regex
pattern: '[Rr]eviewer [Mm]atrix|[Ss]tep\s*5[^\n]*[Ss]tep\s*2|[Ss]tep\s*2[^\n]*[Ss]tep\s*5'
match: contains
target: {source: file, path: findings.md}
# fixture: absent
# must-pass: - Step 2 sends exports using the reviewer matrix, which is only created in Step 5 (AC-07.5).
# must-fail: - Step 2 is fine.
---
Step 2 routes exports through the Reviewer Matrix, which step 5 creates later in the same cycle (AC-07.5).
