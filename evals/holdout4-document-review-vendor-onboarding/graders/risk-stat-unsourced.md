---
type: regex
pattern: '(?:\b70\s*(?:%|percent|per cent))[\s\S]{0,250}(?:(?:source|cite|citation|unverif|not verified|unsupported|evidence|reference|backing|substantiat|no link))|(?:(?:source|cite|citation|unverif|not verified|unsupported|evidence|reference|backing|substantiat|no link))[\s\S]{0,250}(?:\b70\s*(?:%|percent|per cent))'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: 3.3 claims preferred vendors have 70% fewer incidents with no source; mark it unverified.
# must-pass: | F8 | 3.3 | `70 %` statistic is unsourced |
# must-fail: Preferred vendors have 70% fewer security incidents.
# must-fail: All risk statistics cite their source.
---
The 70% fewer-incidents claim in 3.3 has no source and is not marked unverified (standard req 8).
