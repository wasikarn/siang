---
name: humanize-th-order-holdout
tags: [humanize, planted, holdout]
runs: 1
max_turns: 12
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) on `handoff.md`. It is a Slack message from a Thai backend developer handing the on-call shift to a teammate after an incident (genre: Slack standup / handoff, internal, Thai). No writing sample is available.

Work through the skill's loop (draft, "still AI" bullets, final) in your turn, then make your final message the final rewrite only, verbatim, with nothing before or after it.

If the Skill tool reports the skill as unknown or unavailable, do the same humanize task yourself and still end with the final message described above.
