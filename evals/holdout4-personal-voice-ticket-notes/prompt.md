---
name: holdout4-personal-voice-ticket-notes
tags: [holdout, personal-voice]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`) on my ticket notes in `samples/` and write a draft of my note for ticket PAY-2318. Save it as `draft.md`. What happened today, 12 Nov:

- 2:05 pm: we deployed v4.12.0 to prod.
- 2:12 pm: the error rate on the /refunds endpoint reached 7%.
- 2:22 pm: Nok rolled back to v4.11.3 and the error rate went back to normal.
- Cause: the migration that adds the refund_reason column was not in the release.
- Next step: add a CI check that fails the build when a release is missing a migration.

Do not change anything in `samples/`.

Your final message is one line naming the file you wrote, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
