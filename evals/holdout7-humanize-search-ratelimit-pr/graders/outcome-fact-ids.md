---
type: regex
pattern: '^(?=[\s\S]*rl:search:\{api_key_id\})(?=[\s\S]*\b120[- ]?(?:s\b|sec|second))(?=[\s\S]*search\.rate_limit\.enabled)(?=[\s\S]*search_ratelimit_rejected_total)(?=[\s\S]*#4150\b)'
match: contains
target: {source: file, path: PR_DESCRIPTION.md}
# must-pass: Key `rl:search:{api_key_id}`, 120-second TTL; flag `search.rate_limit.enabled`; metric `search_ratelimit_rejected_total`. Closes #4150.
# must-pass: Key rl:search:{api_key_id} with a 120 s TTL, flag search.rate_limit.enabled, metric search_ratelimit_rejected_total, closes #4150
# must-fail: Key `rl:search:{key_id}`, 120-second TTL; flag `search.rate_limit.enabled`; metric `search_ratelimit_rejected_total`. Closes #4150.
# must-fail: Key `rl:search:{api_key_id}`, 120-second TTL; flag `search.ratelimit.enabled`; metric `search_ratelimit_rejected_total`. Closes #4150.
# must-fail: Key `rl:search:{api_key_id}`, 2-minute TTL; flag `search.rate_limit.enabled`; metric `search_ratelimit_rejected_total`. Closes #4150.
---
Names stay exact: the Redis key `rl:search:{api_key_id}` and its 120-second TTL, the flag `search.rate_limit.enabled`, the metric `search_ratelimit_rejected_total`, and the `Closes #4150` link.
