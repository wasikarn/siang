---
type: regex
pattern: '840\s?ms[\s\S]*210\s?ms|210\s?ms[\s\S]*840\s?ms'
flags: i
match: contains
target: {source: file, path: pr-description.md}
# fixture: present
---
Both latency numbers (840ms before, 210ms after) survive.
