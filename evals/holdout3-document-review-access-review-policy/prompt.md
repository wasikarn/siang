---
name: holdout3-document-review-access-review-policy
tags: [holdout, document-review]
runs: 1
max_turns: 20
timeout_seconds: 900
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:document-review` skill (Skill tool, `skill: "siang:document-review"`) to check our user access review policy, `policy.md`, against the internal control it has to satisfy, `control-standard.md`, before the auditors see it. Review only: leave `policy.md` unchanged. Put your findings ledger in `findings.md`, one row or entry per finding with the policy location (section or step), the problem, and the control clause (AC-07.x) it relates to, if any. Do not list things that are fine.

Your final message is one line giving the number of findings, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
