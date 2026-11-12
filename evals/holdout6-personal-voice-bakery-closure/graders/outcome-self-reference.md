---
type: regex
pattern: 'พี่(?!ๆ)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: เตาอบเสีย พี่ขอปิดร้านสามวันนะคะ
# must-fail: ทางร้านขอแจ้งหยุดสามวันค่ะ
# must-fail: แอดมินขอแจ้งปิดร้านนะคะ
# must-fail: พี่ๆ ทุกคน ร้านปิด 15-17 ธ.ค. นะคะ
---
In every sample the owner calls herself "พี่"; the draft does too, not "ทางร้าน" or "แอดมิน" alone.
