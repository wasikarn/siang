---
type: regex
pattern: '!|\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDEFF]|\uD83E[\uDD00-\uDEFF]|[☀-➿]'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: thanks for bearing with us ~d
# must-pass: checkout down ~40 min, questions -> OPS-2187 ~d
# must-fail: thanks all!
# must-fail: checkout down 40 min 🙏 ~d
# must-fail: priya has it ✅ ~d
---
No sample has an exclamation mark or an emoji, so the rewrite has none (the draft ends a sentence with "!").
