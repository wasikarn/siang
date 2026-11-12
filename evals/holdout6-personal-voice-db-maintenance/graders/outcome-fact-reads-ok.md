---
type: regex
pattern: '\breads?\b[\s\S]{0,60}(?:keep|still|continue|unaffected|not affected|fine|work|ok\b|stay|unchanged)'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: Reads keep working the whole time.
# must-pass: reads are not affected.
# must-fail: Writes fail for up to 10 minutes.
---
Reads keep working through the window.
