---
type: regex
pattern: '(habit|one-off)[\s\S]*sample|sample[\s\S]*(habit|one-off)'
match: contains
flags: i
target: {source: file, path: voice.md}
# fixture: absent
---
The profile separates habits from one-offs and cites samples.
