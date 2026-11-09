---
type: regex
pattern: 'REDIS_URL[^\n]{0,40}(?:restart|รีสตาร์ท)'
match: contains
target: last_message
# fixture: absent
---
The `REDIS_URL` trigger is kept and now comes before the restart on the same line. Copying the
source, or deleting the sentence, fails.
