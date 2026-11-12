---
type: regex
pattern: '(?:^|\n)#ขนมปังซอยแปด\s*$'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: #ขนมปังซอยแปด
# must-fail: #ขนมปังซอยแปด #สโตเลน
# must-fail: ขอบคุณค่ะ #ขนมปังซอยแปด
---
Every sample ends with the single hashtag "#ขนมปังซอยแปด" on its own last line.
