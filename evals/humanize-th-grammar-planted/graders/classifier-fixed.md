---
type: regex
pattern: '3 ?(เครื่อง|ตัว|VMs?\b|instances?\b)'
match: contains
target: last_message
# fixture: absent
---
§53: the count survives with an accepted classifier (`3 เครื่อง`, `3 ตัว`, `3 VM`); dropping the
count fails.
