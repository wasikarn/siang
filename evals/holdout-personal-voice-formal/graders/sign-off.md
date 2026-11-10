---
type: regex
pattern: 'With thanks,?\s*\n?\s*Margit\s*$'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
---
Every sample ends with "With thanks, Margit"; the draft ends with a team sign-off.
