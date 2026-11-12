---
type: regex
pattern: '(?:\b6\.4\b)[\s\S]{0,250}(?:(?:does not exist|doesn.t exist|not exist|no such|nonexistent|non-existent|missing|dangling|broken|invalid|unresolved|not found|undefined|not defined|absent|there is no|has no|only has|only goes|only runs|ends at|stops at|points nowhere|no section|no matching))|(?:(?:does not exist|doesn.t exist|not exist|no such|nonexistent|non-existent|missing|dangling|broken|invalid|unresolved|not found|undefined|not defined|absent|there is no|has no|only has|only goes|only runs|ends at|stops at|points nowhere|no section|no matching))[\s\S]{0,250}(?:\b6\.4\b)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: | F1 | Section 3 step 5 | Cross-reference to section 6.4, which does not exist (section 6 ends at 6.3). |
# must-pass: Broken reference: step 5 says to follow §6.4 but there is no such section.
# must-fail: Section 6.4 describes what to do when every replica lags.
# must-fail: A cross-reference in section 3 points to a section that does not exist.
---
Section 3 step 5 sends the reader to section 6.4; section 6 stops at 6.3 (standard req 4).
