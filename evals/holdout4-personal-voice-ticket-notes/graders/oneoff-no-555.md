---
type: regex
pattern: '555|^\s*$'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: - 14:22 Nok rollback กลับ v4.11.3
# must-pass: error rate กลับมาปกติ
# must-fail: rollback ทันพอดี 555
# must-fail: 5555 รอบนี้รอด
---
"555" appears in one note only (03). The draft has none.
