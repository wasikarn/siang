---
type: regex
pattern: '^(?=[\s\S]*(?:(?:2026-11-17|Nov(?:ember|\.)? 17\b)[^\n]*(?<![\d.])5 ?%|(?<![\d.])5 ?%[^\n]*(?:2026-11-17|Nov(?:ember|\.)? 17\b)))(?=[\s\S]*(?:(?:2026-11-19|Nov(?:ember|\.)? 19\b)[^\n]*(?<![\d.])50 ?%|(?<![\d.])50 ?%[^\n]*(?:2026-11-19|Nov(?:ember|\.)? 19\b)))(?=[\s\S]*(?:(?:2026-11-24|Nov(?:ember|\.)? 24\b)[^\n]*(?<![\d.])100 ?%|(?<![\d.])100 ?%[^\n]*(?:2026-11-24|Nov(?:ember|\.)? 24\b)))'
match: contains
target: {source: file, path: PR_DESCRIPTION.md}
# must-pass: 2026-11-17: 5% of keys; 2026-11-19: 50% of keys; 2026-11-24: 100% of keys
# must-pass: 5% on Nov 17, 50% on Nov 19, 100% on Nov 24
# must-fail: 2026-11-17: 10% of keys; 2026-11-19: 50% of keys; 2026-11-24: 100% of keys
# must-fail: 2026-11-17: 5% of keys; 2026-11-24: 100% of keys
---
Each rollout step keeps its date and share on one line: 5% on 2026-11-17, 50% on 2026-11-19, 100% on 2026-11-24. "Nov 17" style dates are fine.
