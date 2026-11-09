---
type: regex
pattern: '(\u0E0D\u0E31\u0E4D[\s\S]*){12}'
match: contains
target: {source: file, path: check.txt}
# fixture: absent
---
All 12 lines read ญ ั ํ (the range that must split once mapped).
