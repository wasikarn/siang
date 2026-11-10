---
type: regex
pattern: 'evict[^\n]{0,60}(?:logout|ล็อกเอาต์|log out|หลุด|เด้งออก)'
match: contains
target: last_message
# fixture: absent
---
The evict condition is kept and now comes before its result on the same line. Copying the source,
or deleting the sentence, fails.
