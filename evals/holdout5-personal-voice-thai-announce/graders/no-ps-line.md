---
type: regex
pattern: '(?:^|\n)[ \t]*(?:ปล|ป\.ล|P\.S|PS)[.:]|^(?![\s\S])'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: ติดอะไรทักใน #infra ได้เลย
# must-pass: มี migration ใน payments ใช้ราว 10 นาที
# must-fail: ปล. ใครยืมสาย HDMI ไปเอาคืนด้วย
# must-fail: P.S. อย่าลืม standup
---
One-off quirk (only the on-call sample): a closing "ปล." postscript. The draft has none.
