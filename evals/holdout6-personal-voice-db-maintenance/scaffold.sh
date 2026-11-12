#!/usr/bin/env bash
# Plants samples/: five #eng-announcements posts by Mara, an SRE lead. Recurring habits (every post):
# first line starts "tl;dr:", times are 24h with UTC ("09:00 UTC", never am/pm), no exclamation
# marks, lists are numbered "1)" (never "1." or bullets), last line is "-m". No post ends with an
# offer of help ("let me know", "reach out", "thanks for your patience").
# One-offs (one post each): a "P.S." line (02, cake in the kitchen) and an apology for short notice
# (03). A draft should copy neither.
set -euo pipefail
mkdir -p samples

cat > samples/01-redis-failover.md <<'EOF'
tl;dr: the sessions Redis fails over to the new cluster Tue Feb 10, 09:00-09:30 UTC. Logins may bounce once.

What happens: we promote the replica in eu-west-1b and point the session service at it. The old
primary stays up read-only for a day in case we need to flip back.

What you need to do:
1) Nothing, if your service gets sessions through the auth client.
2) If you talk to Redis directly (you know who you are), switch to `sessions-redis.internal` before Mon Feb 9.
3) Watch for a spike of 401s right after 09:00 UTC. A few is expected. A few hundred is not, so page me.

Runbook is in the wiki under Redis / failover.
-m
EOF

cat > samples/02-oncall-rotation.md <<'EOF'
tl;dr: on-call handover moves from Monday 10:00 UTC to Wednesday 15:00 UTC, starting Wed Feb 18.

Why: Monday handovers keep landing on top of the weekend backlog and nobody gets a clean start.
Wednesday afternoon is the quietest slot we have in the pager data for the last two quarters.

1) Your current shift ends at the new time, so the week of Feb 16 is two days longer for whoever holds it. Swap in the sheet if that hurts.
2) PagerDuty schedules are already updated. Check yours shows the right person.
3) The handover doc template did not change.

P.S. there is leftover cake from Priya's farewell in the 4th floor kitchen. Go.
-m
EOF

cat > samples/03-cert-rotation.md <<'EOF'
tl;dr: internal TLS certs rotate tonight at 22:00 UTC, sorry for the short notice on this one.

The intermediate CA expires earlier than we had in the tracker (our mistake, the date was copied
from the old CA). We rotate everything signed by it in one go.

1) Services that load certs from the mounted secret pick up the new ones on restart. We do the restarts.
2) Anything that pins the old intermediate breaks. As far as we know that is only the legacy billing exporter, and Tom is on it.
3) If you see `x509: certificate signed by unknown authority` after 22:00 UTC, that is this. Post in #infra-help with the service name.

Should take about 40 minutes end to end.
-m
EOF

cat > samples/04-log-retention.md <<'EOF'
tl;dr: application logs older than 30 days get deleted from Loki starting Mon Mar 2. Today it is 90.

Storage for logs went past compute for the first time last month, and almost every query we
looked at touches the last week anyway. Audit logs are not affected, they live somewhere else and
keep their 1 year.

If you really need older logs for something:
1) Export what you need before Mon Mar 2, 00:00 UTC.
2) Or ask for an exception in the infra tracker with the service name and a reason. Exceptions are reviewed every quarter.

The deletion job runs daily at 03:00 UTC.
-m
EOF

cat > samples/05-staging-reset.md <<'EOF'
tl;dr: staging databases get wiped and reloaded from the anonymised snapshot every Sunday at 02:00 UTC, first run Sun Mar 8.

Staging drifted so far from prod that two incidents last month passed staging and broke in prod.
A weekly reset keeps the schema and data shape close.

1) Anything you keep only in staging is gone Sunday morning. Seed scripts belong in your repo.
2) Test accounts are recreated from `staging-seed.yaml`. Add yours there.
3) The reset takes about 25 minutes. Staging is read-only during it.
-m
EOF
