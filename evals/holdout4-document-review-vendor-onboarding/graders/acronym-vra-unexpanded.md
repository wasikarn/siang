---
type: regex
pattern: '(?:\bVRA\b)[\s\S]{0,200}(?:(?:expand|expansion|spell|spelt|defin|undefined|unexplained|acronym|abbreviat|meaning|stands for|first use))|(?:(?:expand|expansion|spell|spelt|defin|undefined|unexplained|acronym|abbreviat|meaning|stands for|first use))[\s\S]{0,200}(?:\bVRA\b)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: VRA in 4.1 step 2 is never spelled out.
# must-pass: | F5 | 4.1 | Acronym `VRA` undefined |
# must-fail: The Security reviewer completes the VRA.
# must-fail: NDA, DPA and ERP are expanded at first use.
---
VRA is used in 4.1 step 2 and never spelled out (standard req 3).
