---
type: regex
pattern: '^(?:(?:\{"id":[ \t]*"c\d{3}",[ \t]*"text":[ \t]*"[^"\\\n]*"\}|\{"text":[ \t]*"[^"\\\n]*",[ \t]*"id":[ \t]*"c\d{3}"\})\n){39}(?:\{"id":[ \t]*"c\d{3}",[ \t]*"text":[ \t]*"[^"\\\n]*"\}|\{"text":[ \t]*"[^"\\\n]*",[ \t]*"id":[ \t]*"c\d{3}"\})\n?$'
match: contains
target: {source: file, path: chunks.jsonl}
---
The file stays 40 JSON lines with an id and a text key (either order), and no backslash escapes: an ASCII-escaped dump (่) is useless to a Thai grep or tokenizer.
