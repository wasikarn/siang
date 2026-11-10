---
name: humanize-file-prose-only
tags: [humanize, planted]
runs: 1
max_turns: 12
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:humanize` skill (Skill tool, `skill: "siang:humanize"`) to humanize `README.md` in place: edit the file so its prose reads human. Genre D, English.

Your final message is the full content of the edited `README.md`, verbatim, and nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same humanize task yourself and still end with the final message described above.
