---
type: regex
pattern: '^(?=[\s\S]*INC-2291)(?=[\s\S]*(?:2026-10-14|14 Oct(?:ober)? 2026|Oct(?:ober)? 14,? 2026))(?=[\s\S]*\b47(?:\s|-)?min)(?=[\s\S]*\b1,?284\b)(?=[\s\S]*\b512\b)(?=[\s\S]*Priya Raman)(?=[\s\S]*v3\.18\.3)'
match: contains
target: {source: file, path: INCIDENT-2291.md}
# must-pass: INC-2291: on October 14, 2026 checkout broke for 47 minutes; 1284 checkouts failed; 512 idle conns; Priya Raman; fix in v3.18.3.
# must-pass: # INC-2291 ... 2026-10-14 ... 47-minute outage ... 1,284 failed ... 512 per pod ... Priya Raman ... v3.18.3
# must-fail: INC-2291: on 2026-10-14 checkout broke for 47 minutes; 1,284 checkouts failed; a large idle pool; Priya Raman; fix in v3.18.3.
# must-fail: INC-2291 on 2026-10-14, 47 minutes, about 1,300 failed, 512 idle, Priya Raman, v3.18.3
---
Seven facts survive, in any wording: INC-2291, 2026-10-14, 47 minutes, 1,284 failed checkouts, 512 idle connections per pod (only in the hedged sentence), Priya Raman, v3.18.3.
