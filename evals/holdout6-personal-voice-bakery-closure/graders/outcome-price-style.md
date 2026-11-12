---
type: regex
pattern: '^(?![\s\S]*\d\s*บาท)[\s\S]*\b390\.-'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: สโตเลนก้อนละ 390.-
# must-fail: สโตเลนก้อนละ 390 บาท
# must-fail: ก้อนละ 390.- (390 บาท)
# must-fail: ราคา 390฿
---
Every price in the samples is written "65.-", never with "บาท"; the prompt's "390 baht" comes out as "390.-".
