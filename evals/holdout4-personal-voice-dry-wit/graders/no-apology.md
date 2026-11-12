---
type: regex
pattern: '\bsorry\b|\b(?:we|i)(?: [a-z]+)? apologi[sz]e|\b(?:our|my) (?:sincere |deepest )?apologies|^\s*apologies|apologies for|\bwe regret|^\s*$'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: CertPoint sent an apology. Priya renewed the cert anyway.
# must-pass: Not our finest afternoon.
# must-fail: Sorry for the disruption.
# must-fail: We apologise for the inconvenience.
---
The user supplied no apology and none of their samples apologises. The draft does not add one of its own (reporting the vendor's apology is fine).
