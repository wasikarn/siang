---
type: regex
pattern: '(ค่ะ|คะ)[\s\S]*(ค่ะ|คะ)[^ก-๛]*$'
match: contains
target: last_message
---
Smoke test for SKILL.md genre C (human reply to a customer) and §40: at least two `ค่ะ`/`คะ`, and the last Thai word of the reply is one of them (a bare closing sentence reads curt). Before 0.1.1 the rule capped particles at one opener; a rewrite that still follows it fails here. `คะ` versus `ค่ะ` correctness is left to `criteria`.
