---
type: regex
pattern: '^(?!(?:\S+\s+){70}\S)[\s\S]*\S'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: heads up, payments db maintenance thu 14 nov 22:00-22:40 utc, checkout down ~40 min. priya nair is running it. no deploys to payments in that window. questions on OPS-2187 ~d
# must-fail: we would like to let everyone know that there is going to be some scheduled maintenance of the payments database happening on thursday the 14th of november from 22:00 until 22:40 utc and during that window the checkout service is expected to be unavailable for roughly 40 minutes so please plan around it and also note that priya nair will be leading the migration and nobody should deploy to payments during it ok ~d
---
Dana's messages run 20 to 30 words; the rewrite stays under 70 words (the draft is over 90).
