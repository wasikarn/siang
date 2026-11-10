---
type: regex
pattern: 'หวังว่า[\s\S]{0,20}เป็นประโยชน์|ข้อสงสัยประการใด|สอบถามได้ตลอด|กล่าวโดยสรุป'
flags: u
match: not_contains
target: {source: file, path: incident-note.md}
# fixture: present
---
The chatbot wrap-up (in summary, hope this helps, ask any time) is gone.
