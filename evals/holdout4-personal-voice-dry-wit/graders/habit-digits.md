---
type: regex
pattern: '\b(?:two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|twenty|thirty|forty|fifty|hundred|thousand)\b|^\s*$'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: Lost checkout for 38 minutes, 1,240 requests.
# must-pass: Alert fires 14 days out.
# must-fail: Lost checkout for thirty-eight minutes.
# must-fail: Alert fires two weeks out.
---
The user writes every number as digits (all 5 samples). No spelled-out numbers ("one" is left out: it is also a pronoun).
