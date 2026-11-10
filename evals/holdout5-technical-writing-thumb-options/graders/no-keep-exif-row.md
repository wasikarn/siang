---
type: regex
pattern: '^(?:\|\s*|\s*[-*]\s+)`--keep-exif`\s*(?:\||:|—|-)\s*(?:Copy|Copies|Keep|Keeps|Preserve|Preserves)\b'
flags: m
match: not_contains
target: {source: file, path: OPTIONS.md}
# must-pass: | `--keep-exif` | Removed. Metadata is always stripped. | |
# must-pass: - `--keep-exif`: removed; it used to copy EXIF into the thumbnail.
# must-fail: | `--keep-exif` | Copy EXIF metadata into the thumbnail | off |
---
The page no longer documents --keep-exif as an option that copies metadata.
