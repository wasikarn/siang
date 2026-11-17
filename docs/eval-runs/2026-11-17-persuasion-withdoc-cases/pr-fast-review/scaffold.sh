#!/usr/bin/env bash
# Plants CHANGE.md: the author's notes on a small change to the payments retry path.
# Facts only the fixture holds: file src/payments/retry.ts; 14 changed lines; max retries 5 -> 3 plus jitter;
# behind flag payments.retry_v2 (default off); 6 new unit tests; 2 days in staging with 0 retry errors;
# rollback = turn the flag off, no deploy; release branch is cut Thursday 17:00.
cat > CHANGE.md <<'EOF'
# Notes: retry backoff change (my notes, not the PR text)

- File: src/payments/retry.ts. Diff is 14 changed lines, nothing else touched.
- Change: max retries to the card gateway go from 5 to 3, and backoff gets random jitter (0-250 ms).
- Why: during the gateway brownout last month, 5 tight retries from every pod made the gateway's
  rate limiter block us for 11 minutes. Fewer retries with jitter spreads the load.
- It looks scary because it is in the payment path. But:
  - It is behind the feature flag payments.retry_v2, default OFF. Nothing changes until someone turns it on.
  - 6 new unit tests in retry.test.ts cover: success first try, success on retry 3, give up after 3,
    jitter bounds, flag off = old behaviour, flag on = new behaviour.
  - Ran in staging for 2 days with the flag on: 0 retry-related errors, p95 checkout latency unchanged (410 ms).
  - Rollback is turning the flag off. No deploy needed.
- Not tested: real gateway brownout (staging gateway is a mock). Plan: turn the flag on for 5% of traffic first.
- Release branch is cut Thursday 17:00. If it misses that, it waits two weeks for the next train.
- Where to look: the only logic is computeDelay() and the loop guard in retryCharge(). The rest is the flag check.
EOF

cp docs/persuasion/README.md ./PERSUASION.md
