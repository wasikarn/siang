#!/usr/bin/env bash
# Plants METRICS.md: real numbers for the billing-sync refactor ask.
# Facts only the fixture holds: 9 P2 incidents in 6 months, 7 traced to billing-sync; 46 on-call hours;
# changes in billing-sync take 3.2 days vs 1.1 elsewhere; test coverage 31%, target 70%;
# ask = 2 engineers for 2 weeks (20 engineer-days); cost = invoice PDF v2 moves 2 weeks later.
cat > METRICS.md <<'EOF'
# billing-sync: numbers for the refactor ask (last 6 months)

- P2 incidents across the billing team: 9. Of those, 7 were traced to billing-sync (retry and state handling).
- On-call time spent on those 7 incidents: 46 hours total.
- Lead time for a change inside billing-sync: 3.2 days on average. Same team, other modules: 1.1 days.
- Test coverage of billing-sync: 31%. Other billing modules: 68-75%.
- Plan: split the sync state machine out of the HTTP handlers, add tests around retries, target 70% coverage.
- Ask: 2 engineers for 2 weeks (20 engineer-days), starting the sprint after next.
- Cost: invoice PDF v2 (roadmap item, no external date promised) would move 2 weeks later.
- What we do not know: whether incidents drop to zero. Our guess is that most of the 7 would not have happened,
  but we have no proof yet. We can report incidents and lead time again 3 months after.
EOF
