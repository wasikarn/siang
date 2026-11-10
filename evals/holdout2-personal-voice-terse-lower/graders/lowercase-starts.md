---
type: regex
pattern: '^(?![\s\S]*(?:(?:^|\n)[^\S\n]*(?:[-*>]|\d+[.)])?[^\S\n]*|[.?:;]\s+)(?!Priya|Nair)[A-Z][a-z])(?![\s\S]*\bI\b)[\s\S]*[a-z]'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: heads up, payments db maintenance thu 14 nov. checkout is down ~40 min. Priya Nair runs it. ~d
# must-pass: i will be around. questions on OPS-2187, 22:00 UTC start ~d
# must-pass: heads up: payments db goes down thu 14 nov ~d
# must-fail: Heads up, payments db maintenance thu 14 nov ~d
# must-fail: payments db goes down thu. Checkout is out 40 min ~d
# must-fail: i will be around, I can answer questions ~d
# must-fail: heads up: Checkout is out 40 min ~d
---
Dana starts every line and sentence in lowercase and writes "i" in lowercase. Names (Priya Nair) and all-caps ids (OPS-2187, UTC) may keep their capitals.
