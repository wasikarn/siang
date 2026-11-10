---
type: regex
pattern: 'default[^\n]*\bwebp\b|\bwebp\b[^\n]*default|\|\s*`?webp`?\s*\|'
flags: i
match: contains
target: {source: file, path: OPTIONS.md}
# fixture: absent
# must-pass: | `--format FMT` | Output format: `png`, `webp` or `avif` | `webp` |
# must-pass: `--format` defaults to webp.
# must-fail: | `--format FMT` | Output format: `jpeg` or `png` | `jpeg` |
---
--format now defaults to webp. The page gives webp as the default.
