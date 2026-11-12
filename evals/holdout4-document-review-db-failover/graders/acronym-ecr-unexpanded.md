---
type: regex
pattern: '(?:\bECR\b)[\s\S]{0,200}(?:(?:expand|expansion|spell|spelt|defin|undefined|unexplained|acronym|abbreviat|meaning|stands for|first use))|(?:(?:expand|expansion|spell|spelt|defin|undefined|unexplained|acronym|abbreviat|meaning|stands for|first use))[\s\S]{0,200}(?:\bECR\b)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: ECR (section 4.1 step 4) is never spelled out.
# must-pass: | F5 | 4.1 | Acronym `ECR` not expanded at first use |
# must-fail: Open an ECR in the change tracker.
# must-fail: Other acronyms (RPO, RTO, VIP) are expanded at first use.
---
ECR is used in 4.1 step 4 and never spelled out (standard req 3).
