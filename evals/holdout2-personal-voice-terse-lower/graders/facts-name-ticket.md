---
type: regex
pattern: '^(?=[\s\S]*ops-2187)(?=[\s\S]*priya)[\s\S]*deploy'
flags: i
match: contains
target: {source: file, path: draft.md}
# must-pass: priya nair is running the migration. no deploys to payments while it runs. questions on OPS-2187 ~d
# must-pass: pls hold payments deploys, priya is doing the migration. questions -> ops-2187
# must-fail: the migration runs thursday, questions in the thread ~d
# must-fail: priya is running it, ask on OPS-2187 ~d
---
Facts kept: the ticket OPS-2187, Priya (who leads the migration) and the deploy freeze on payments. A lowercased ticket id or name still counts.
