---
type: regex
pattern: 'apologi|inconvenience|unfortunately'
match: not_contains
flags: i
target: {source: file, path: draft.md}
---
The samples never apologise or soften; the draft drops the apology and the opener.
