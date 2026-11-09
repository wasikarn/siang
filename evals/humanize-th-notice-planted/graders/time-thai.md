---
type: regex
pattern: '01\.00( น\.)? ?(–|-|ถึง) ?03\.00 น\.'
match: contains
target: last_message
# fixture: absent
---
§56: 24-hour time with a dot, zero-padded, then `น.`: `01.00–03.00 น.` (or `01.00 น. ถึง 03.00 น.`).
