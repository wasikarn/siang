---
type: regex
pattern: '^(?=[\s\S]*workers/export\.py)(?=[\s\S]*4 minutes)(?=[\s\S]*30)'
match: contains
target: last_message
---
The specifics survive: the worker file, the new 4-minute run, and the old 30-minute timeout.
