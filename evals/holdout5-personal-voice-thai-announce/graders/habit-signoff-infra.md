---
type: regex
pattern: 'ติดอะไร[^\n]{0,20}ทัก[^\n]{0,20}#infra'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: ติดอะไรทักใน #infra ได้เลย
# must-pass: ติดอะไรทักมาที่ #infra ได้เลยครับ
# must-fail: หากมีข้อสงสัยสามารถสอบถามได้ที่ #infra
# must-fail: ติดอะไรทักมาได้เลย
---
Shared habit (all five user samples): the announcement closes with "ติดอะไรทักใน #infra ได้เลย".
