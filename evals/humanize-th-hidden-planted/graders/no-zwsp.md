---
type: regex
pattern: '\u200B'
match: not_contains
target: last_message
---
§58: zero-width spaces (U+200B) are stripped from edited prose. The fixture plants two, inside
sentences that need no other change, so a rewrite that copies those sentences keeps them.
`scan.py` does not flag U+200B, so only a writer who knows §58 looks for it.
