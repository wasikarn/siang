---
name: trigger-humanize
tags: [trigger]
description: Autonomous trigger test, expects skill "siang:humanize", prompt never names it
runs: 3
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Here is my standup update for the team channel. It reads like a chatbot wrote it. Make it sound like a person wrote it, and put the result in `update.md`.

```
In today's fast-paced engineering landscape, I'm thrilled to share that the payments migration is a robust, seamless, and transformative step forward. Let's delve into the details: we shipped the new endpoint, and QA is underway.
```

When you are done, your final message is one line saying what you did.
