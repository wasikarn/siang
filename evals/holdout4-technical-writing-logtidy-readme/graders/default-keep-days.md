---
type: regex
pattern: '(?:default|keep|days?|--keep-days|keep_days)[^\n]{0,80}\b14\b|\b14\b[^\n]{0,80}(?:default|days?)'
flags: i
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: `--keep-days` defaults to 14 (set in `logtidy.ini`).
# must-pass: | `--keep-days N` | `14` (from `keep_days` in logtidy.ini) | Keep files modified within N days |
# must-pass: By default logtidy keeps the last 14 days of logs.
# must-fail: Files older than 30 days are deleted by default.
---
The default retention is 14 days, read from `keep_days = 14` in `logtidy.ini`, not the 30 the stale README claims. Any wording or a table row that ties 14 to the default, days or the flag passes.
