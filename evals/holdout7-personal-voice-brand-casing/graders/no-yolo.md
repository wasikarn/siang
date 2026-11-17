---
type: regex
pattern: '^(?![\s\S]*yolo)[\s\S]*dev-2087'
flags: i
match: contains
target: {source: file, path: draft.md}
# must-pass: ปล่อยแล้ว มีปัญหาแจ้ง DEV-2087 ได้เลย
# must-pass: iOS 5.4.1 พร้อม แจ้งใน dev-2087
# must-fail: ปล่อย yolo เลย แจ้ง DEV-2087
# must-fail: ปล่อยแล้ว YOLO แจ้ง DEV-2087
# must-fail: ปล่อยแล้ว แจ้งในทีม
---
The word "yolo" appears in one sample only, so it is a one-off, not part of Mint's voice: the rewrite does not add it. The ticket id must still be there.
