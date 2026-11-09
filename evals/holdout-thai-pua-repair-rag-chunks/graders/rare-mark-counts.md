---
type: regex
pattern: '^(?=[^๊]*๊[^๊]*$)(?=[^๋]*(?:๋[^๋]*){2}$)[^์]*(?:์[^์]*){18}$'
match: contains
target: {source: file, path: chunks.jsonl}
# fixture: absent
---
The rarer marks map back too: one mai tri (U+F715 in ปั๊ม), two mai chattawa (U+F70D in ก๋วย plus the standard one in เตี๋ยว) and 18 thanthakhat (U+F70E lowered, 3 raw).
