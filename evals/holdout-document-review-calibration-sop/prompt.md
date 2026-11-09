---
name: holdout-document-review-calibration-sop
tags: [holdout, document-review]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:document-review` skill (Skill tool, `skill: "siang:document-review"`) to review `sop-ph-meter.md` against the standard in `standard.md`. Review only: do not edit `sop-ph-meter.md`. Overwrite `review.md` with your findings, each with its location in the record.

Your final message is one line saying how many findings you wrote to `review.md`, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
