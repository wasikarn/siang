---
type: regex
pattern: '(?:\bno\b|don.?t|do not|hold|freeze|pause|avoid|stop)[\s\S]{0,40}deploy|deploy[\s\S]{0,30}(?:freeze|hold|pause)'
match: contains
target: {source: file, path: draft.md}
flags: i
# fixture: absent
# must-pass: 2) Do not deploy anything that touches orders-db during the window.
# must-pass: No deploys to services that touch orders-db between 14:00 and 16:00 UTC.
# must-pass: Deploy freeze for anything touching orders-db.
# must-fail: Deploy your service as usual.
# must-pass: 2) Don’t deploy anything that touches orders-db.
---
No deploys of anything that touches orders-db during the window.
