---
type: regex
pattern: '(?:\b8\s*(?:s\b|secs?\b|seconds?\b)|eight seconds|\bp99\b)[\s\S]{0,250}(?:(?:source|cite|citation|unverif|not verified|unsupported|evidence|reference|backing|substantiat|no link))|(?:(?:source|cite|citation|unverif|not verified|unsupported|evidence|reference|backing|substantiat|no link))[\s\S]{0,250}(?:\b8\s*(?:s\b|secs?\b|seconds?\b)|eight seconds|\bp99\b)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: 2.3 claims Patroni promotes in under 8 seconds at p99 with no source; mark it unverified.
# must-pass: | F8 | 2.3 | p99 promotion claim is unsourced |
# must-fail: Patroni promotes a healthy replica in under 8 seconds at p99.
# must-fail: Every performance claim cites a dashboard.
---
The 8-second p99 promotion time in 2.3 has no source and is not marked unverified (standard req 9).
