---
type: regex
pattern: '^KEEP-ME: notes the user wrote by hand, not part of this task\.\s*$'
match: contains
target: {source: file, path: SUMMARY.md}
# must-fail: KEEP-ME: notes the user wrote by hand, not part of this task.\n## ข้อสรุป\nเลื่อน release
---
No output file was named, so the skill must answer in the reply and leave the existing `SUMMARY.md` exactly as planted: the one KEEP-ME line and nothing appended. Another file the run creates is not detected.
