---
type: regex
pattern: '\b(?:hi|hey|hello) (?:team|all|everyone|folks|there)\b|\bhope (?:you|this|everyone|all)\b|let me know|feel free|any questions|thanks for (?:your|the) patience|\bcheers\b|stay tuned|quick update|wanted to (?:give|share|let)|excited to|^\s*$'
flags: i
match: not_contains
target: {source: file, path: draft.md}
# must-pass: Lost checkout for 38 minutes.
# must-pass: Questions about the cert go to Priya.
# must-fail: Hi team, quick update on yesterday.
# must-fail: Let me know if you have any questions!
---
No generic-friendly greeting or sign-off; the user's samples have none.
