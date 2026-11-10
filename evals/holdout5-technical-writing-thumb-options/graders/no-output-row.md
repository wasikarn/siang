---
type: regex
pattern: '^\|\s*`--output[^`]*`\s*\|[^\n]*`\./thumbs`'
flags: m
match: not_contains
target: {source: file, path: OPTIONS.md}
# must-pass: | `--output` | `--out-dir` | The old name is rejected. |
# must-pass: | `--out-dir DIR` | Directory the thumbnails are written to | `thumbs` |
# must-fail: | `--output DIR` | Directory the thumbnails are written to | `./thumbs` |
---
The 2.x row that documents --output as a current option, with its old default, is gone.
