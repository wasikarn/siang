---
type: regex
pattern: '^(?=[\s\S]*(?<![\d.])4\.8 ?s(?:ec|econds)?\b)(?=[\s\S]*(?:2026-11-03|Nov(?:ember|\.)? 3\b))(?=[\s\S]*(?<![\d,])9,?000 requests)(?=[\s\S]*\b(?:two|2) ?min)'
match: contains
target: {source: file, path: PR_DESCRIPTION.md}
# must-pass: In the 2026-11-03 incident search p99 hit 4.8 s after one key sent 9,000 requests in two minutes.
# must-pass: On Nov 3 p99 reached 4.8s; one key sent 9000 requests in 2 minutes.
# must-fail: In the 2026-11-03 incident search p99 hit 5 s after one key sent 9,000 requests in two minutes.
# must-fail: In the 2026-11-03 incident search p99 spiked after one key flooded us.
---
The reason for the change keeps its numbers: p99 at 4.8 s, the 2026-11-03 incident, 9,000 requests in two minutes from one key.
