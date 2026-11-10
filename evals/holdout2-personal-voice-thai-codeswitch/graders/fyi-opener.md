---
type: regex
pattern: '^[^\n]*\bfyi\b'
flags: i
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: fyi ศุกร์นี้ deploy ฮะ
# must-pass: FYI deploy ศุกร์นี้ฮะ
# must-fail: ศุกร์นี้ deploy ฮะ
# must-fail: แจ้งให้ทราบ ศุกร์นี้ deploy ฮะ
---
Every sample opens with "fyi"; the rewrite opens its first line the same way instead of a salutation.
