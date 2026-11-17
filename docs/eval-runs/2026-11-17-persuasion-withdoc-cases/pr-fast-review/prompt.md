---
name: pr-fast-review
tags: [holdout, persuasion]
runs: 1
max_turns: 20
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep]
---
First read `PERSUASION.md` in this directory and follow it when drafting.
I need a quick review on my PR and the reviewer is busy. Read `CHANGE.md` (my notes on the change) and write the PR description to `PR.md`. The reviewer is the payments tech lead; she gets a lot of review requests and skips long ones. I want her to review it today, before the release branch is cut.

Your final message is one line naming the file you wrote, nothing else.
