---
type: regex
pattern: '\b(?:delve|robust|comprehensive|seamless(?:ly)?|leverag(?:e|es|ed|ing)|game-?changer|significant step|more important than ever)\b'
match: not_contains
target: {source: file, path: PR_DESCRIPTION.md}
flags: i
# must-pass: This adds a token-bucket rate limiter to `GET /v2/search`, kept in Redis.
# must-fail: This adds a robust rate limiter to `GET /v2/search`.
# must-fail: We leverage a token bucket in Redis.
# must-fail: Let's delve into the dashboard.
# must-fail: A significant step for reliability.
---
Promotional vocabulary goes: delve, robust, comprehensive, seamless, leverage, game-changer, "significant step", "more important than ever".
