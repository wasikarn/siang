---
type: regex
pattern: 'zero[ -]?(?:customer[ -]?)?impact|customer impact|earlier changes'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
---
Defect: section 2 claims zero customer impact from earlier changes and cites no ticket or result.
