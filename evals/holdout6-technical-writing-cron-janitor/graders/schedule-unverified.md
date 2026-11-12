---
type: regex
pattern: '^(?![\s\S]*(?:^|\n)(?![^\n]*(?:\bTODO\b|\bTBD\b|unverified|not verified|could ?n[o'']t (?:confirm|verify|find)|cannot (?:confirm|verify|be confirmed)|\bunknown\b|not (?:yet )?known|no longer|moved off|used to))[^\n]*\b0 3 \* \* \*)[\s\S]*?(?:(?:\bTODO\b|\bTBD\b|unverified|not verified|could ?n[o'']t (?:confirm|verify|find)|cannot (?:confirm|verify|be confirmed)|\bunknown\b|not (?:yet )?known)[^\n]{0,120}(?:schedule|cron|time|slot|hour)|(?:schedule|cron|crontab|slot)[^\n]{0,120}(?:\bTODO\b|\bTBD\b|unverified|not verified|could ?n[o'']t (?:confirm|verify|find)|cannot (?:confirm|verify|be confirmed)|\bunknown\b|not (?:yet )?known))'
match: contains
target: {source: file, path: README.md}
flags: i
# fixture: absent
# must-pass: Schedule: TODO: verify the cron slot with ops; it moved off 03:00 (OPS-412).
# must-pass: Add the crontab line at the time ops gives you (TBD, see OPS-412): `MM HH * * * JANITOR_ROOT=/srv/uploads python3 /opt/janitor/janitor.py`
# must-fail: 0 3 * * * JANITOR_ROOT=/srv/uploads python3 /opt/janitor/janitor.py
# must-fail: Runs nightly from cron at 03:00.
---
The cron slot moved off 03:00 (code comment, OPS-412) and the new time is not in the repo. The doc must flag it as unconfirmed near the schedule and must not give `0 3 * * *` as the line to install.
