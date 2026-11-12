---
type: regex
pattern: '^(?![\s\S]*\b(?:per|each) (?:user|IP|account|client)\b)(?=[\s\S]*(?<![\d.])120 ?(?:requests?|req)? ?(?:per|a|/) ?min)(?=[\s\S]*burst[^\n:]{0,15}(?<![\d.])30\b)(?=[\s\S]*\bper API key\b)'
match: contains
target: {source: file, path: PR_DESCRIPTION.md}
flags: i
# must-pass: Each API key gets 120 requests per minute, with a burst of 30, so the limit is per API key.
# must-pass: Limit is 120 req/min per API key, burst of up to 30.
# must-fail: Each user gets 120 requests per minute, burst of 30, per API key.
# must-fail: 120 requests per minute per API key.
# must-fail: 100 requests per minute per API key, with a burst of 30.
---
The limit in prose: 120 requests a minute, a burst of 30, scoped per API key (not per or each user, IP, account or client). The YAML block's `burst: 30` does not count, so the prose fact cannot be dropped behind it.
