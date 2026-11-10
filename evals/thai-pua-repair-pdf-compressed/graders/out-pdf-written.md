---
type: regex
pattern: '^%PDF-'
match: contains
target: {source: file, path: out.pdf}
# fixture: absent
---
The file `out.pdf` exists and is a PDF; a run that writes no `out.pdf` fails. It cannot tell a repaired PDF from a copy of `in.pdf`: the eval has only regex-on-file, last-message and tool-use graders, and the repaired streams are compressed.
