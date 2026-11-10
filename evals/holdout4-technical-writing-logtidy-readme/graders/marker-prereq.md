---
type: regex
pattern: '\.logtidy-ok'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: touch /var/log/myapp/.logtidy-ok
---
The README tells the reader to create the `.logtidy-ok` marker file in the target directory; without it logtidy exits with "refusing to touch".
