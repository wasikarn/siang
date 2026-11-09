---
type: regex
pattern: '^(?=[\s\S]*มาตรา ๒๔ )(?=[\s\S]*\(๑\) จัด)(?=[\s\S]*๑๕ มีนาคม)[^]*(?:[^]*){3}$'
match: contains
target: {source: file, path: regulation-clean.txt}
---
U+F71B has no known standard Thai character. All three stay where they were (after มาตรา ๒๔, after (๑), after ๑๕), exactly three in the file: not deleted, not replaced by a guessed character.
