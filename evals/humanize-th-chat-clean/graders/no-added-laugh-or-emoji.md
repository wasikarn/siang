---
type: regex
pattern: '^(?![\s\S]*\p{Extended_Pictographic})(?![\s\S]*555)'
match: contains
flags: u
target: last_message
---
§39.1 ("keep when present, never add") and cue #18: the source has no `555` and no emoji, so
the rewrite adds none. Written as `contains` with lookaheads so it matches the clean fixture.
