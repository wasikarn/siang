---
type: regex
pattern: '^\s*tl;dr:'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: tl;dr: orders-db moves to Postgres 17 on Thu Mar 19, 14:00-16:00 UTC.
# must-pass:   tl;dr: Postgres 17 for orders-db, Thu Mar 19.
# must-fail: TL;DR: orders-db moves to Postgres 17 on Thu Mar 19.
# must-fail: Heads up: orders-db maintenance on Thu Mar 19. tl;dr: writes fail for 10 minutes.
---
Every sample opens with a lowercase `tl;dr:` line; the draft opens the same way.
