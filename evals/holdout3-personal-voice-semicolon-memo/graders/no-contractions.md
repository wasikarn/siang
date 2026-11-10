---
type: regex
pattern: '\b[A-Za-z]+[''’](?:t|re|ll|ve|m|d)\b'
match: not_contains
target: {source: file, path: draft.md}
flags: i
# must-pass: I do not expect it to slip; everyone's figures are in the workbook.
# must-fail: We’ll need to address it.
# must-fail: I don't expect it to slip.
---
Marta never contracts (do not, I would, it is); the draft has I'm, we've, we'll, couldn't, don't. Possessives such as everyone's stay allowed.
