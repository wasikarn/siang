---
type: regex
pattern: '(?:\b8\.2\b)[\s\S]{0,250}(?:(?:does not exist|doesn.t exist|not exist|no such|nonexistent|non-existent|missing|dangling|broken|invalid|unresolved|not found|undefined|not defined|absent|there is no|has no|only has|only goes|only runs|ends at|stops at|points nowhere|no section|no matching))|(?:(?:does not exist|doesn.t exist|not exist|no such|nonexistent|non-existent|missing|dangling|broken|invalid|unresolved|not found|undefined|not defined|absent|there is no|has no|only has|only goes|only runs|ends at|stops at|points nowhere|no section|no matching))[\s\S]{0,250}(?:\b8\.2\b)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: | F1 | 5 step 3 | Reactivation points to section 8.2, which does not exist (the document ends at section 7). |
# must-pass: Broken cross-reference: §8.2 is not defined anywhere.
# must-fail: Reactivation follows section 8.2.
# must-fail: A cross-reference in section 5 points to a section that does not exist.
---
Section 5 step 3 sends reactivation to section 8.2; the document ends at section 7 (standard req 4).
