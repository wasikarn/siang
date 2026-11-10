---
name: holdout3-document-review-backup-runbook
tags: [holdout, document-review]
runs: 1
max_turns: 20
timeout_seconds: 900
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:document-review` skill (Skill tool, `skill: "siang:document-review"`) to audit `runbook.md`, our restore runbook for the orders database, against our runbook standard in `runbook-standard.md`. This is a review only: do not edit `runbook.md`. Write a findings ledger to `review.md`: one entry per finding, each with its location in the runbook (section or step number), what is wrong, and which rule of the standard it breaks, if any. Only report real problems.

Your final message is one line giving the number of findings, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
