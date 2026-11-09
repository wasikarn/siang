---
type: regex
pattern: '^(?:\{"id": ?"c\d{3}", ?"text": ?"[^"\\\n]*"\}\n){40}$'
match: contains
target: {source: file, path: chunks.jsonl}
---
The file stays 40 JSON lines with id then text, and no backslash escapes: an ASCII-escaped dump (่) is useless to a Thai grep or tokenizer.
