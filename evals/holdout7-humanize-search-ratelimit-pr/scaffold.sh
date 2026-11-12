#!/usr/bin/env bash
# Plants PR_DESCRIPTION.md: a PR body a careless LLM wrote. Tells: "In today's fast-paced", a
# robust/scalable/comprehensive triple, "game-changer", "Not only... but also", "seamless",
# "leverage", "It's worth noting", "delve", "In conclusion... significant step forward", em dash,
# emoji, bold-colon bullet labels. Traps: 120/min per API key with burst 30, 429 + Retry-After,
# rl:search:{api_key_id} with 120-second TTL, the 2026-11-03 incident numbers, #4150, the flag and
# metric names, three dated rollout steps, a YAML block and a half-done testing checklist
# (INFRA-77 still unchecked) that must stay as they are.
set -euo pipefail

cat > PR_DESCRIPTION.md <<'EOF'
# Add per-key rate limiting to /v2/search 🚀

## What

In today's fast-paced API landscape, protecting our infrastructure is more important than ever. This PR introduces a robust, scalable, and comprehensive rate limiter for `GET /v2/search` — a true game-changer for platform stability.

Not only does it protect the search cluster, but it also delivers a seamless experience for well-behaved clients. Under the hood, we leverage a token bucket stored in Redis:

- **Limit:** 120 requests per minute per API key, with a burst of 30.
- **Response:** Over-limit requests get HTTP 429 with a `Retry-After` header (seconds until the next token).
- **Storage:** One Redis key per API key, `rl:search:{api_key_id}`, with a 120-second TTL.

## Why

It's worth noting that search p99 latency hit 4.8 s during the 2026-11-03 incident, when a single key sent 9,000 requests in two minutes. Closes #4150.

## Rollout

The limiter ships behind the flag `search.rate_limit.enabled`, which is off by default:

```yaml
search:
  rate_limit:
    enabled: false
    requests_per_minute: 120
    burst: 30
```

- 2026-11-17: 5% of keys
- 2026-11-19: 50% of keys
- 2026-11-24: 100% of keys

Rejections are counted in `search_ratelimit_rejected_total`, labelled by `api_key_id`. Let's delve into that dashboard together after each step!

## Testing

- [x] Unit tests for bucket refill and burst (`go test ./internal/ratelimit/...`)
- [x] Integration test that the 121st request in a minute gets 429
- [ ] Load test against staging (blocked on INFRA-77)

In conclusion, this change represents a significant step forward in our ongoing commitment to reliability and developer experience. 🎉
EOF
