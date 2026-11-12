---
type: regex
pattern: '(?:\b7\s*-?\s*(?:years?|yrs?)\b|seven years)[\s\S]{0,300}(?:\b60\s*-?\s*months?\b|sixty months|\b5\s*-?\s*(?:years?|yrs?)\b|five years)|(?:\b60\s*-?\s*months?\b|sixty months|\b5\s*-?\s*(?:years?|yrs?)\b|five years)[\s\S]{0,300}(?:\b7\s*-?\s*(?:years?|yrs?)\b|seven years)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: Retention conflict: 2.4 says 7 years, 6.2 says 60 months.
# must-pass: | F3 | 6.2 | Deleted after `60 months` (5 years) contradicts the 7-year retention in 2.4 |
# must-fail: Keep the vendor file for 7 years after the contract ends.
# must-fail: Due-diligence records are deleted 60 months after the contract ends.
---
2.4 keeps due-diligence records 7 years; 6.2 deletes them after 60 months (standard req 6).
