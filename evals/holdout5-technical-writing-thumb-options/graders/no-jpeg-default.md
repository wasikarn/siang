---
type: regex
pattern: '--format\b[^\n]*\|\s*`?jpe?g`?\s*\|\s*$|\bdefaults? (?:is|to|format is)\s+`?jpe?g\b|\bdefault:\s*`?jpe?g\b'
flags: mi
match: not_contains
target: {source: file, path: OPTIONS.md}
# must-pass: JPEG output was dropped; the default was jpeg in 2.x and is now webp.
# must-pass: | format default jpeg | format default webp |
# must-pass: | `--format FMT` | Output format: `png`, `webp` or `avif` | `webp` |
# must-fail: | `--format FMT` | Output format: `jpeg` or `png` | `jpeg` |
# must-fail: `--format` defaults to jpeg.
---
jpeg is no longer an output format, so it is not given as the --format default.
