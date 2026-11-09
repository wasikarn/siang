---
type: regex
pattern: '^(?=[\s\S]*ปัจจัยที่มีผล)(?=[\s\S]*ความกตัญญูต่อบุพการี)(?=[\s\S]*ฟื้นฟูสมรรถภาพ)(?=[\s\S]*ป้าคนหนึ่ง)(?=[\s\S]*ก๋วยเตี๋ยว)(?=[\s\S]*ปั๊มดูดเสมหะ)(?=[\s\S]*หกสิบปีขึ้นไป)(?=[\s\S]*เป็นแรงจูงใจ)'
match: contains
target: {source: file, path: chunks.jsonl}
# fixture: absent
---
Left-shifted vowels and tones after ป ฝ ฟ (U+F701..U+F704, U+F710, U+F712, U+F705, U+F706, U+F714, U+F715) and the tail-less yo ying (U+F70F) map to the standard characters, so searchable words come back: ปัจจัย, กตัญญู, ฟื้นฟู, ป้า, ก๋วยเตี๋ยว, ปั๊ม, ปี, เป็น.
