---
type: regex
pattern: 'staging[^\n]*(?<!ไม่)(?<!ไม่ได้)ผ่าน'
match: contains
target: last_message
---
The unverified staging claim is kept, not deleted or reversed (`staging ไม่ผ่าน` fails) (Grit Gate, one unverifiable claim). Its
intensifiers are checked by `calque-gone.md`. Replaces part of the llm `criteria` grader
(GH #921). Limit: an invented test result, ticket or person goes unchecked (evals/README.md, "Known
gap").
