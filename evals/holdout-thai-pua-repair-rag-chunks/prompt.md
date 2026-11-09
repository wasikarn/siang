---
name: holdout-thai-pua-repair-rag-chunks
tags: [holdout, thai-pua-repair]
runs: 1
max_turns: 15
timeout_seconds: 600
allowed_tools: [Bash, Read, Edit, Write, Glob, Grep, Skill]
---
Use the `siang:thai-pua-repair` skill (Skill tool, `skill: "siang:thai-pua-repair"`) on `chunks.jsonl`. These are 40 retrieval chunks cut from the text of a Thai research paper PDF, and our RAG index finds almost nothing when we search them in Thai. Repair the `text` values in place in `chunks.jsonl`: keep one JSON object per line, the same ids in the same order, and Thai as plain UTF-8 (no `\u` escapes). Then write to `pua-left.txt` the exact number of private-use characters (U+E000..U+F8FF) still in `chunks.jsonl` after your repair, digits only.

Your final message is one line saying how many chunks you changed, nothing else.

If the Skill tool reports the skill as unknown or unavailable, do the same task yourself and still end with the final message described above.
