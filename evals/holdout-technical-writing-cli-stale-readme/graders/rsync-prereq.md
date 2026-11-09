---
type: regex
pattern: '\brsync\b'
flags: i
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: You need bash and rsync on your PATH.
# must-fail: Works on any machine with bash, no other dependencies.
---
Missing prerequisite: the script exits with an error when rsync is not on PATH.
