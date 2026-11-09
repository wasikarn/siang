#!/usr/bin/env bash
mkdir -p samples
: > voice.md
printf 'ok pushed the fix, checking staging now\n' > samples/1.txt
printf 'api slow again, looking at the db\n' > samples/2.txt
printf 'rolled back. retry after lunch\n' > samples/3.txt
cat > draft.md <<'FIXTURE_EOF'
Hi team! Unfortunately, we encountered a delay with today's deploy due to a migration lock. We apologize for the inconvenience. The new ETA is tomorrow at 10:00. Please let me know if you have any questions! 😊
FIXTURE_EOF
