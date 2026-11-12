---
name: holdout6-technical-writing-webhook-relay
tags: [holdout, technical-writing]
runs: 1
max_turns: 30
timeout_seconds: 900
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:technical-writing` skill (Skill tool, `skill: "siang:technical-writing"`). This folder holds `relay.py`, which forwards queued webhook events from `spool/` to a receiver, and its `README.md`, which is out of date. A developer on the billing team is about to run the relay for the first time: they will try it against the staging receiver, then point it at production, and they need to know what a failed delivery looks like and where the failed events end up. Rewrite `README.md` in place as a how-to for that developer. Do not edit `relay.py` or anything in `spool/`.

Your final message is one line saying what you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
