---
type: regex
pattern: '\u0E0D\u0E31\u0E4D'
match: contains
target: {source: file, path: check.txt}
# fixture: absent
---
A ToUnicode range whose targets are not consecutive after mapping (F70F..F711) reads as ญ ั ํ.
