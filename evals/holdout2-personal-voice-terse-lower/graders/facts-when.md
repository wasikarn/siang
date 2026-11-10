---
type: regex
pattern: '^(?=[\s\S]*utc)(?=[\s\S]*(?<!\d)40(?!\d))(?=[\s\S]*(?:(?<!\d)14(?:th)?(?!\d)[^\n\d]{0,12}nov|nov[a-z]*\.?\s*14(?!\d)|(?<!\d)14/11(?!\d)|(?<!\d)11/14(?!\d)))[\s\S]*(?:22[:.]?00|10\s?pm)'
flags: i
match: contains
target: {source: file, path: draft.md}
# must-pass: payments db maintenance thu 14 nov, 22:00-22:40 utc. checkout down ~40 min
# must-pass: heads up: nov 14, 10pm UTC, checkout is out for about 40 mins
# must-pass: thursday 14/11 from 22:00 utc, checkout down for 40m ~d
# must-fail: payments db maintenance thursday night, checkout down for a bit ~d
# must-fail: thu 14 nov 22:00 utc, checkout down for a while
# must-fail: thu 15 nov 22:00 utc, checkout down 40 min
---
Facts kept: the date (14 November), the 22:00 UTC start, and the 40-minute outage. Any common short form of the date or time counts.
