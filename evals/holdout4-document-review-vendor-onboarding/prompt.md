---
name: holdout4-document-review-vendor-onboarding
tags: [holdout, document-review]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:document-review` skill (Skill tool, `skill: "siang:document-review"`) to review `docs/vendor-onboarding-procedure.md`, our procedure for setting up new suppliers, against `docs/procurement-doc-standard.md`. This is a review only: do not edit either document. Write your ledger of findings and your verdict (approve, approve-with-changes or reject) to `review.md`.

Your final message is one line naming the verdict, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
