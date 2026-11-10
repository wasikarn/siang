---
type: regex
pattern: '[ก-๛](?<!ต่าง) ๆ[\s\S]*[ก-๛](?<!ต่าง)ๆ|[ก-๛](?<!ต่าง)ๆ[\s\S]*[ก-๛](?<!ต่าง) ๆ'
match: not_contains
target: last_message
---
§58: one `ๆ` spacing form per piece. The fixture mixes `ง่ายๆ` and `หลาย ๆ`; either form alone
passes. `ต่าง ๆ` always takes the space (§58), so it is skipped on both sides.
