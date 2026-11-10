---
type: regex
pattern: '^(?=[\s\S]*ดิจิทัล)(?=[\s\S]*ลิงก์)(?=[\s\S]*อีเมล(?!์))'
match: contains
target: last_message
# fixture: absent
---
§31: the corrected forms are present, not just the wrong ones removed: `ดิจิทัล`, `ลิงก์` and `อีเมล` (no `์`). A rewrite that drops the words to dodge the spelling fails here.
