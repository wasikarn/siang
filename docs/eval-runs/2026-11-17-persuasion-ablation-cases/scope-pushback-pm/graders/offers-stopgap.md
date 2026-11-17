---
type: regex
pattern: 'one[- ]off|stopgap|interim|in the meantime|meanwhile|(?:export|query|send|pull|run)[^.\n]{0,40}(?:manual(?:ly)?|by hand)|(?:manual(?:ly)?|by hand)[^.\n]{0,40}(?:export|query|send|pull)'
flags: i
match: contains
target: {source: file, path: REPLY.md}
# must-pass: Meanwhile we can send Northwind a one-off export.
# must-pass: We can pull it by hand this week.
# must-fail: Let's wait for sprint 25.
# must-fail: I know their finance team rebuilds it by hand every week.
---
The draft offers the 1-hour stopgap so the customer gets something now. Plain "by hand" or "manual" counts only next to export, query, send, pull or run, so echoing the PM's "rebuilds it by hand" does not pass.
