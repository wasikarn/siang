---
type: regex
pattern: '(?:stays|remains|is) (?:valid|accepted|trusted) for (?:7|seven) days'
match: not_contains
target: {source: file, path: ROTATION.md}
# must-pass: In 1.x the previous key stayed valid for 7 days; 2.0 cuts this to 48 hours.
# must-pass: The previous key stays valid for 48 hours.
# must-fail: The previous key stays valid for 7 days.
---
The doc does not state the 1.x seven-day grace period as current behaviour.
