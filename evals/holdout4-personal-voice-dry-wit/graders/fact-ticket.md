---
type: regex
pattern: 'INC-?5582'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: Logged as INC-5582.
# must-pass: Ticket INC5582 has the timeline.
# must-fail: Logged as INC-5528.
# must-fail: The ticket has the timeline.
---
The ticket id INC-5582 from the prompt survives.
