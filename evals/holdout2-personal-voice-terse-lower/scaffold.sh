#!/usr/bin/env bash
# Builds samples/: three short team-chat messages by one engineer, Dana. Shared in every sample: all
# lowercase (including "i"), no exclamation marks, no emoji, "fwiw" as filler, signed "~d".
# One-off quirk in sample-2 only: ALL-CAPS emphasis ("do NOT force push"); a rewrite must not copy it.
# draft.md is a stiff formal announcement to rewrite in place, keeping every fact.
set -euo pipefail
mkdir -p samples

cat > samples/sample-1.md <<'EOF'
heads up, staging gets wiped tonight around 9. fwiw nothing on it is load-bearing, but grab your test data first if you care about it.
ping me if it breaks anything
~d
EOF

cat > samples/sample-2.md <<'EOF'
merged the retry fix (BE-412), deploys are unblocked. fwiw the flaky test was the clock, not us.
please do NOT force push to main again, it ate two commits last time.
~d
EOF

cat > samples/sample-3.md <<'EOF'
on-call swap: i'm out fri, sam has the pager. fwiw the runbook is current as of tuesday.
questions go in this thread, not dms
~d
EOF

cat > draft.md <<'EOF'
Dear Team,

We would like to inform you that scheduled maintenance of the payments database will take place on Thursday, 14 November, from 22:00 to 22:40 UTC. During this window, the checkout service will be unavailable for approximately 40 minutes.

Please be advised that Priya Nair will be leading the migration. All engineers are kindly requested to refrain from deploying to the payments service during this period.

Should you have any questions or concerns, please do not hesitate to raise them on ticket OPS-2187. We sincerely appreciate your patience and understanding!

Kind regards,
Platform Engineering Team
EOF
