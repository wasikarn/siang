---
name: holdout5-personal-voice-review-comments
tags: [holdout, personal-voice]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:personal-voice` skill (Skill tool, `skill: "siang:personal-voice"`) on the writing samples in `samples/` and write my review comments on PR #231 (a new retry helper in the Go client) in my voice. Save them to `draft.md`. Word it however fits my voice, but every point below must be in the draft, and do not add any point I did not list:

- Blocking. On line 58 of client/retry.go, you must put a ceiling on the backoff. Right now the delay keeps doubling with no limit.
- Blocking. You should not retry on a 400 response. Please only retry 5xx and 429.
- Not blocking. Line 12 of client/retry_test.go uses time.Sleep, so the test takes 8 seconds. You need to switch to a fake clock.
- Question. Where does the default of 3 attempts come from? Is it from the design doc?

Your final message is one line naming the file you wrote, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
