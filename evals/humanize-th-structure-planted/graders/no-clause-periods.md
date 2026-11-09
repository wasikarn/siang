---
type: regex
pattern: '[A-Za-zก-๛]{2}\. '
match: not_contains
target: last_message
---
§45: Thai separates short clauses with a space, not a period; the planted `orders. ` and `เร็วขึ้น. ` go.
Two letters before the period, so abbreviations such as `ก.พ.` and `พ.ศ.` pass.
