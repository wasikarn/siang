---
type: regex
pattern: '[ก-๛]{10,}'
match: contains
target: {source: file, path: UPDATE.md}
# must-pass: ขอเลื่อนวัน go-live ออกไป 3 วัน
# must-fail: Requesting a 3-day delay to go-live.
---
The update is written in Thai (at least one run of 10 Thai characters).
