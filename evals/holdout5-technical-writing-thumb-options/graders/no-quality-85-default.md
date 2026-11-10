---
type: regex
pattern: '--quality\b[^\n]*\|\s*`?85`?\s*\|\s*$|quality[^\n]*\bdefaults? (?:is|to)\s+`?85\b|quality[^\n]*\bdefault:\s*`?85\b'
flags: mi
match: not_contains
target: {source: file, path: OPTIONS.md}
# must-pass: The --quality default dropped from 85 to 82.
# must-pass: python3 thumb.py --quality 85 photo.png
# must-pass: | quality default 85 | quality default 82 |
# must-fail: | `--quality Q` | Encoder quality, 1-100 | `85` |
# must-fail: `--quality` defaults to 85.
---
The 2.x --quality default of 85 is not given as the current default.
