---
type: regex
pattern: 'quality[\s\S]{0,300}?\b82\b'
flags: i
match: contains
target: {source: file, path: OPTIONS.md}
# fixture: absent
# must-pass: | `--quality Q` | `82` | Encoder quality, 1-100 |
# must-fail: | `--quality Q` | Encoder quality, 1-100 | `85` |
---
The --quality default is 82 in 3.0.0, a change only thumb.py shows. The page gives 82.
