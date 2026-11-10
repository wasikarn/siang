---
name: holdout5-technical-writing-key-rotation
tags: [holdout, technical-writing]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`) to rewrite `ROTATION.md`, our on-call how-to for rotating the signer service's signing key. It has not been touched since before `rotate-key.sh` 2.0 (see `CHANGELOG.md`). The reader is an on-call engineer on a fresh shell who must finish the rotation from this page alone: list everything that has to be in place before the first step, give the steps in the order they must run, and say how long clients can keep using the previous key. `rotate-key.sh` is the source of truth. Do not change `rotate-key.sh` or `CHANGELOG.md`; do not run `rotate-key.sh`.

Your final message is one line naming the file you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
