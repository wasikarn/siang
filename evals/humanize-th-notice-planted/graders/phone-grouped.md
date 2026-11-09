---
type: regex
pattern: '081-234-5678|\+66 81 234 5678'
match: contains
target: last_message
# fixture: absent
---
§56: a phone number in user-facing copy is grouped (`081-234-5678` or `+66 81 234 5678`), and it keeps every digit of the source's `0812345678`.
