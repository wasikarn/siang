---
type: regex
pattern: '--output\b[\s\S]{0,300}?--out-dir|--out-dir[\s\S]{0,300}?--output\b'
match: contains
target: {source: file, path: OPTIONS.md}
# fixture: absent
# must-pass: | `--output` | Renamed to `--out-dir` in 3.0 |
# must-pass: - Replace `--out-dir` for every `--output` in your scripts.
# must-fail: | `--out-dir DIR` | Directory the thumbnails are written to | `thumbs` |
---
3.0.0 renamed --output to --out-dir. The page names both, close together, so an upgrader can map one to the other.
