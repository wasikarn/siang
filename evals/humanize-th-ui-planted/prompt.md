---
name: humanize-th-ui-planted
tags: [humanize, planted]
runs: 1
max_turns: 12
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) on `payment-declined.md`. It is the copy for a payment-declined screen shown to Thai end users (genre C, UI, Thai with English only where a user would read it). No writing sample is available.

Work through the skill's loop (draft, "still AI" bullets, final) in your turn, then make your final message the final rewrite only, verbatim, with nothing before or after it.

If the Skill tool reports the skill as unknown or unavailable, do the same humanize task yourself and still end with the final message described above.
