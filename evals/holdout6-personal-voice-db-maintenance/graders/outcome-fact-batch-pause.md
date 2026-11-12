---
type: regex
pattern: 'batch[\s\S]{0,120}(?:13:45|1:45\s?pm)|(?:13:45|1:45\s?pm)[\s\S]{0,120}batch'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: 1) Pause any batch job that writes to orders before 13:45 UTC.
# must-pass: Before 13:45 UTC, pause your batch jobs.
# must-fail: 1) Pause any batch job that writes to orders before the window.
---
Batch jobs that write to orders are paused before 13:45 UTC (1:45pm in the prompt).
