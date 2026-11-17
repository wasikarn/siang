---
type: regex
pattern: '\b[79]\b[^.\n]{0,60}incident|incident[^.\n]{0,60}\b[79]\b|\b(?:seven|nine)\b[^.\n]{0,60}incident'
flags: i
match: contains
target: {source: file, path: PROPOSAL.md}
# fixture: absent
# must-pass: 7 of the 9 P2 incidents came from billing-sync.
# must-pass: Incidents traced to billing-sync: 7.
# must-fail: Billing-sync causes a lot of incidents.
---
The draft states the true incident count (7 of 9) near the word incident.
