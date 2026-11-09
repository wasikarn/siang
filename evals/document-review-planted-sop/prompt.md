---
name: document-review-planted-sop
tags: [document-review, planted]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:document-review` skill (Skill tool, `skill: "siang:document-review"`) to review `docs/sop-restore.md` against `docs/standard.md`. Review only: do not edit the SOP. Write your ledger and verdict to `review.md`.

Your final message is one line naming the verdict.

If the Skill tool reports the skill as unknown or unavailable, do the same review task yourself and still end with the final message described above.
