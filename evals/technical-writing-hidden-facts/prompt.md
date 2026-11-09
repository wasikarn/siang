---
name: technical-writing-hidden-facts
tags: [technical-writing, planted]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) to rewrite `docs/sync-assets.md` in place. It must serve two readers: an engineer running `bin/sync-assets` for the first time, and one looking up every flag and exit code. The tool is `bin/sync-assets`.

Your final message is the skill's delivery block (assumptions and any `TODO: verify`), nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
