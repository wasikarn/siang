---
type: regex
pattern: '\b(?:[A-Za-z]+n[''’]t|[A-Za-z]+[''’](?:re|ll|ve|m|d)|(?:it|that|there|here|what|let|he|she|who)[''’]s)\b'
flags: i
match: not_contains
target: {source: file, path: draft.md}
---
The samples use no contractions; the draft has several.
