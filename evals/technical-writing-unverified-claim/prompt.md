---
name: technical-writing-unverified-claim
tags: [technical-writing, planted]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) to fix `docs/rotate-key.md` in place. The reader is an on-call engineer who has never run the tool. The tool is `bin/rotate-key`.

Your final message is the skill's delivery block (assumptions and any `TODO: verify`), nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same technical-writing task yourself and still end with the final message described above.
