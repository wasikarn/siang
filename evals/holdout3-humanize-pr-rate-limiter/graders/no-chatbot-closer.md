---
type: regex
pattern: '\bdelve|let me know if you have any questions|in conclusion|happy to (?:help|answer|delve)'
flags: i
match: not_contains
target: {source: file, path: pr-description.md}
# fixture: present
---
The chatbot sign-off (in conclusion, happy to delve deeper, let me know if you have any questions) is gone.
