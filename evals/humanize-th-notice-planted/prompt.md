---
name: humanize-th-notice-planted
tags: [humanize, planted]
runs: 1
max_turns: 12
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) on `notice.md`. It is an in-app maintenance notice that a bank app shows to its Thai users (genre C, user-facing, Thai). The year in the draft is on the CE calendar. No writing sample is available.

Work through the skill's loop (draft, "still AI" bullets, final) in your turn, then make your final message the final rewrite only, verbatim, with nothing before or after it.

If the Skill tool reports the skill as unknown or unavailable, do the same humanize task yourself and still end with the final message described above.
