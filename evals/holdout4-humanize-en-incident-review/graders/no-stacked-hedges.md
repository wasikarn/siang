---
type: regex
pattern: 'could potentially|may have possibly|potentially be argued|it could be argued'
flags: i
match: not_contains
target: {source: file, path: INCIDENT-2291.md}
# must-pass: Our idle pool of 512 connections per pod made things worse; checkout needs far fewer.
# must-pass: The 512 idle connections per pod probably made it worse.
# must-fail: It could potentially be argued that our idle pool size may have possibly made things worse.
# must-fail: The pool size may have possibly contributed, since 512 idle connections is a lot.
---
The planted sentence stacks three hedges ("could potentially be argued", "may have possibly"). Any rewording that drops the stack passes; one plain hedge such as "probably" is fine.
