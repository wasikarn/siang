---
type: regex
pattern: '\b45[\s-]*(?:h|hrs?|hours?)\b|[Dd]orman[^\n]*\bhours?\b|\bhours?\b[^\n]*[Dd]orman'
match: contains
target: {source: file, path: findings.md}
# fixture: absent
# must-pass: | §6 table | Dormancy limit reads 45 hours; §4 says 45 days | AC-07.3 |
# must-pass: - The dormancy row in the §6 table uses hours where §4 uses days.
# must-fail: | §4 | Dormancy 45 days is stricter than AC-07.3 |
---
Section 4 disables accounts after 45 days without login; the section 6 table gives the dormancy limit as 45 hours. The finding names "45 hours" or ties dormancy to hours.
