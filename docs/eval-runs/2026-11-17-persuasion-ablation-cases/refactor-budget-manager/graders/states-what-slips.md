---
type: regex
pattern: 'invoice[ -]?pdf'
flags: i
match: contains
target: {source: file, path: PROPOSAL.md}
# fixture: absent
# must-pass: Invoice PDF v2 moves two weeks later.
# must-fail: No impact on the roadmap.
---
The draft names the roadmap item that slips, the cost the manager must defend.
