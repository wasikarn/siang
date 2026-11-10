---
type: regex
pattern: '(?:—|–|--) ?Marta\s*$'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: The ledger is due on 2026-03-14. — Marta
# must-fail: — Marta wrote this. Best regards, The Finance Team
---
Each sample ends with a line "— Marta"; the draft ends with a team signature. The rewrite must end with her sign-off (an en dash or double hyphen also passes).
