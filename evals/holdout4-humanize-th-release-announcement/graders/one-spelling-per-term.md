---
type: regex
pattern: '^(?:(?=[\s\S]*ดีพลอย)(?=[\s\S]*[Dd]eploy)|(?=[\s\S]*แคช)(?=[\s\S]*(?<![A-Za-z_])[Cc]ache(?![A-Za-z_])))'
match: not_contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: เราจะ deploy 4.7.0 และย้าย cache ของ tenant config ไปไว้ใน Redis ระหว่าง deploy อาจช้าลง 5 นาที
# must-pass: ย้ายแคชไป Redis ระหว่างดีพลอยอาจช้าลง 5 นาที ตาราง `cache_ttl` ไม่เปลี่ยน
# must-fail: เราจะ deploy 4.7.0 ระหว่างดีพลอยอาจช้าลง 5 นาที
# must-fail: ย้ายแคชของ tenant config ไป Redis การแยก cache ออกจาก process
---
The fixture spells two terms two ways (deploy and ดีพลอย, cache and แคช). The rewrite picks one spelling per term. An identifier such as cache_ttl does not count as the English spelling.
