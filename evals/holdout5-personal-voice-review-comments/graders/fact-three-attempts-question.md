---
type: regex
pattern: '^(?=[\s\S]*design doc)(?=[\s\S]*(?:\b(?:3|three)\b[^\n]{0,40}(?:attempt|retr|tries)|(?:attempt|retr|tries)[^\n]{0,40}\b(?:3|three)\b))'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: q: where does the default of 3 attempts come from? the design doc?
# must-pass: q: is three retries from the design doc or a guess?
# must-fail: q: where does the default come from? the design doc?
# must-fail: q: why 3 attempts?
---
Fact 4: the question about where the default of 3 attempts comes from, and whether it is in the design doc.
