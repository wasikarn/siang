---
name: holdout6-personal-voice-db-maintenance
tags: [holdout, personal-voice]
runs: 1
max_turns: 30
timeout_seconds: 900
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`) on the writing samples in `samples/` and write my next post for the #eng-announcements channel, in my voice, saved to `draft.md`. The samples are my last few posts there.

It announces the orders-db maintenance. Facts it must contain:
- The orders-db primary moves from Postgres 15 to Postgres 17 on Thursday March 19, 2pm to 4pm UTC.
- During the switchover, writes to orders fail for up to 10 minutes. Reads keep working the whole time.
- What teams need to do: pause any batch job that writes to orders before 1:45pm UTC that day; do not deploy anything that touches orders-db during the window; after 4pm UTC, check your service's error dashboard.
- If the switchover fails, we stay on Postgres 15 and try again next Thursday.

Do not add any point I did not list.

Your final message is one line naming the file you wrote, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
