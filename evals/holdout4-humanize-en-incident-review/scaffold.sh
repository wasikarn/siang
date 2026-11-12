#!/usr/bin/env bash
# Plants INCIDENT-2291.md, an incident review with machine-written tells spread through otherwise plain prose:
# stacked hedges ("could potentially be argued ... may have possibly"), vague attribution ("Some engineers have
# noted"), a "not only X but Y" frame, inflated significance ("underscores the importance"), a rule-of-three
# ("swift, coordinated, and transparent"), em dashes, a tidy moral closer ("serves as a valuable reminder") and a
# chat closer ("Let me know if you have any questions").
# Facts that must survive: INC-2291, 2026-10-14, 47 minutes, 1,284 failed checkouts, 512 idle connections,
# Priya Raman, v3.18.3. Must stay byte-identical: the "The release bumped poolkit" paragraph, the YAML block and
# the timeline table. The blockquote is a genuine quote from the poolkit release notes: its "not just X but Y"
# wording is the source's, so it stays.
cat > INCIDENT-2291.md <<'EOF'
# INC-2291: checkout failures after payments-gateway v3.18.2

## Summary

On 2026-10-14 checkout requests failed for 47 minutes after we deployed payments-gateway v3.18.2. In total 1,284 checkouts failed before the rollback to v3.18.1 finished — a significant impact that underscores the importance of our deployment practices.

## What happened

The release bumped poolkit from 1.9 to 2.0. Poolkit 2.0 closes idle connections after 30 seconds instead of keeping them open, so under normal checkout traffic the gateway kept dropping connections and opening new ones. Postgres hit its connection limit four minutes after the deploy finished.

It could potentially be argued that our idle pool size may have possibly made things worse, since 512 idle connections per pod is far more than checkout needs. Some engineers have noted that pool settings are often overlooked during dependency upgrades. The poolkit 2.0 release notes do flag the change:

> "This is not just a defaults change but a behavior change for every long-lived pool."

The failure was not only a configuration issue but a gap in how we review dependency upgrades. Each upgrade PR shows the version bump. No upgrade PR shows the changed defaults. Reviewers approve what the diff shows them.

## Timeline

| Time (UTC) | Event |
|------------|-------|
| 09:12 | v3.18.2 deploy finished |
| 09:16 | Checkout error rate reached 18% |
| 09:31 | Rollback to v3.18.1 started |
| 09:59 | Error rate back under 0.5% |

## Fix

We now set the pool limits explicitly, so the gateway no longer depends on poolkit defaults. The change ships in v3.18.3:

```yaml
db:
  pool:
    max_idle_conns: 64    # explicit since poolkit 2.0
    idle_timeout: 30s
```

The response was swift, coordinated, and transparent — Priya Raman, the on-call engineer, posted an update in the incident channel every ten minutes.

## Follow-ups

- Add a pool-saturation alert to the gateway dashboard (owner: Priya Raman).
- Require a config diff in every dependency upgrade PR.
- Load-test v3.18.3 at twice peak traffic before it ships.

Overall, this incident serves as a valuable reminder that robust monitoring, clear ownership, and disciplined rollouts are the foundation of a resilient platform. Let me know if you have any questions or need further details!
EOF
