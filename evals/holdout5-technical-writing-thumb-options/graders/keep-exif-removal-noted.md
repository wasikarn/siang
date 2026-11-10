---
type: regex
pattern: '--keep-exif[\s\S]{0,300}?(?:remov|no longer|dropped|gone|delet|not (?:supported|available)|unsupported|retired|reject|always strip|never)|(?:remov|dropped|gone|delet|retired)[\s\S]{0,400}?--keep-exif'
flags: i
match: contains
target: {source: file, path: OPTIONS.md}
# fixture: absent
# must-pass: - `--keep-exif`: gone, thumbnails never carry metadata now.
# must-pass: ## Removed in 3.0 - `--keep-exif`
# must-fail: | `--keep-exif` | Copy EXIF metadata into the thumbnail | off |
---
3.0.0 removed --keep-exif. The migration note says so.
