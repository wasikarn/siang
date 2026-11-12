---
type: regex
pattern: '^\s*(?:[A-Z][a-z]*ed|Had|Lost|Spent|Hit|Got|Took|Ran|Saw|Put|Cut|Made|Found|Kept|Broke|Went|Sent|Paid|Shut|Set|Threw|Wrote|Built)\b'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: Lost checkout for 38 minutes yesterday.
# must-pass: Renewed the payments proxy cert after a 38-minute outage.
# must-fail: Hi team, quick update on yesterday.
# must-fail: We lost checkout for 38 minutes yesterday.
---
Every sample opens with a past-tense verb and no subject, greeting or heading. The draft does too.
