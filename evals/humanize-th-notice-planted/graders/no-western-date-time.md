---
type: regex
pattern: 'AM|PM|2027|\d{1,2}:\d{2}'
match: not_contains
target: last_message
---
§56: no AM/PM, no colon time and no CE year in user-facing Thai. The planted `1:00 AM - 3:00 AM` and `03/02/2027` are gone.
