---
name: holdout4-personal-voice-dry-wit
tags: [holdout, personal-voice]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`) on my writing samples in `samples/` and write a draft of my update to the platform team channel about yesterday's checkout outage. Save it as `draft.md`. The facts:

- Ticket: INC-5582.
- Yesterday, 11 Nov, the checkout API returned 502 errors for 38 minutes, from 14:12 to 14:50.
- 1,240 checkout requests failed.
- Cause: the TLS certificate on the internal payments proxy expired. Auto-renew from our certificate vendor, CertPoint, failed without alerting anyone.
- Priya Raman renewed the certificate by hand.
- Reconciliation is still running. Priya thinks no orders were lost and will confirm when it finishes.
- We added an alert that fires two weeks before any certificate expires.

Do not change anything in `samples/`.

Your final message is one line naming the file you wrote, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
