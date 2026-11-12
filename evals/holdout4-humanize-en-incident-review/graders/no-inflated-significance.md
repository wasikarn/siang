---
type: regex
pattern: 'underscores the importance|serves as a (?:valuable |powerful |important |stark )?reminder|foundation of a resilient|resilient platform|swift, coordinated,? and transparent'
flags: i
match: not_contains
target: {source: file, path: INCIDENT-2291.md}
# must-pass: 1,284 checkouts failed before the rollback finished.
# must-pass: Priya Raman posted an update in the incident channel every ten minutes.
# must-fail: Overall, this incident serves as a valuable reminder that robust monitoring matters.
# must-fail: The response was swift, coordinated, and transparent.
---
Three planted inflations: "underscores the importance of our deployment practices", the rule-of-three "swift, coordinated, and transparent", and the closing moral ("serves as a valuable reminder ... foundation of a resilient platform"). Any rewording that drops those phrases passes.
