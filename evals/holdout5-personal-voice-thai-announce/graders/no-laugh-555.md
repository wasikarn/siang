---
type: regex
pattern: '555|^(?![\s\S])'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: ถ้า error rate เกิน 2% จะ rollback ทันที
# must-pass: พฤ. 19 พ.ย. 14:00 จะ deploy
# must-fail: ขอให้ผ่านรอบเดียว 555
# must-fail: ถ้า rollback อีกก็ 5555
---
One-off quirk (only the search-api sample): the laugh "555". The draft has none.
