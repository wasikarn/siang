---
type: regex
pattern: '^(?![\s\S]*(?:^|\n)(?![^\n]*(?:\bTODO\b|\bTBD\b|unverified|not verified|could ?n[o'']t (?:confirm|verify|find)|cannot (?:confirm|verify|be confirmed)|\bunknown\b|not (?:yet )?known|retired|no longer))[^\n]*staging-hooks\.example\.com)[\s\S]*?(?:(?:\bTODO\b|\bTBD\b|unverified|not verified|could ?n[o'']t (?:confirm|verify|find)|cannot (?:confirm|verify|be confirmed)|\bunknown\b|not (?:yet )?known)[^\n]{0,120}(?:staging|URL|endpoint|receiver)|(?:staging|URL|endpoint|receiver)[^\n]{0,120}(?:\bTODO\b|\bTBD\b|unverified|not verified|could ?n[o'']t (?:confirm|verify|find)|cannot (?:confirm|verify|be confirmed)|\bunknown\b|not (?:yet )?known))'
match: contains
target: {source: file, path: README.md}
flags: i
# fixture: absent
# must-pass: Staging receiver URL: TODO: verify with the platform team (the old staging-hooks.example.com host was retired).
# must-pass: 2. Set RELAY_URL to the staging receiver (URL TBD; ask the platform team).
# must-fail: 1. Run `RELAY_URL=https://staging-hooks.example.com/in RELAY_SECRET=s python3 relay.py --dry-run`.
# must-fail: Use the staging receiver, https://staging-hooks.example.com/in, for testing.
---
The staging receiver the old README names was retired and its replacement URL is not in the repo (code comment). The doc must flag the staging URL as unconfirmed and must not hand the reader the retired host.
