---
type: regex
pattern: '[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}]'
flags: u
match: not_contains
target: {source: file, path: pr-description.md}
# fixture: present
---
The decorative emoji are gone.
