---
type: regex
pattern: '^%PDF-'
match: contains
target: {source: file, path: out.pdf}
# fixture: absent
---
The repaired file `out.pdf` exists and is a PDF; a run that only edits `check.txt` by hand fails.
