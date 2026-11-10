---
type: regex
pattern: '(?:\bnot\b|n.t\b|\bnever\b|\bonly\b|\bno\b|skip|ignor|untouched|left alone|non-)[^\n]{0,80}(?:recurs|sub-?dir|sub-?folder|nested|descend|top[- ]level)|(?:recurs|sub-?dir|sub-?folder|nested|descend)[^\n]{0,80}(?:\bnot\b|n.t\b|\bnever\b|skip|ignor|untouched|left alone)|top[- ]level|directly (?:in|inside|under)'
flags: i
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: Only files directly inside `--dir` are checked; subdirectories are skipped.
# must-pass: It does not recurse into subdirectories.
# must-pass: logtidy looks at the top level of the directory only.
# must-fail: Recursively deletes old `.log` files under a directory, including every subdirectory.
---
`os.scandir` reads one directory level, so logtidy never touches `.log` files in subdirectories. The README must say so (any wording) instead of repeating the stale "recursively ... including every subdirectory".
