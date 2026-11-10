---
type: regex
pattern: '^(?=[\s\S]*Okafor)[\s\S]*FIN-2291'
match: contains
target: {source: file, path: draft.md}
# must-fail: Daniel has finished the review; see the ticket.
---
The person (Daniel Okafor) and the ticket id (FIN-2291) survive the rewrite.
