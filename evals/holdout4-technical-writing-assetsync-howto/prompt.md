---
name: holdout4-technical-writing-assetsync-howto
tags: [holdout, technical-writing]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) on `docs/howto-sync-assets.md`. It is the how-to for pushing our built assets to the asset host with `bin/assetsync`, and it no longer matches the script. Fix the how-to so a new teammate can run their first sync without surprises: what they need before they start, the steps and commands, the options with their defaults, and what the sync will and will not do to files on the host. Take every fact from `bin/assetsync`, `assetsync.conf` and `CHANGELOG.md`. Do not change any file other than `docs/howto-sync-assets.md`, and do not run a real sync.

Your final message is one line naming the file you wrote, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
