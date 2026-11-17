#!/usr/bin/env bash
# Plants THREAD.md (PM asks to add CSV export mid-sprint) and SPRINT.md (capacity facts).
# Facts only the fixture holds: sprint 24 ends Friday; 38 of 40 points committed; CSV export estimate 8 points;
# the refund status page is committed to the support team; sprint 25 planning is Monday;
# a one-off manual export from the admin query takes about 1 hour.
cat > THREAD.md <<'EOF'
From: PM (orders product)
To: you
Subject: CSV export for the orders report

Hi! Northwind Retail asked again for a CSV export of the orders report. Their finance team rebuilds it by
hand every week and they're getting annoyed. Can we squeeze it into this sprint? It should be a small thing,
right? Their account review is in three weeks and I'd love to show them we listened.
EOF

cat > SPRINT.md <<'EOF'
# Sprint 24 (ends this Friday)

- Capacity: 40 points. Committed: 38 points.
- Committed items include the refund status page (13 points), promised to the support team for this Friday.
- Team estimate for CSV export of the orders report: 8 points (streaming large reports, column mapping,
  permissions check, tests). Not "small": the report can be 200k rows.
- Adding 8 points now means something committed slips; the only item big enough to cut is the refund page.
- Sprint 25 planning is Monday. CSV export can go in as a top item; it would ship by the end of sprint 25,
  which is before Northwind's account review.
- Stopgap: we can run the existing admin query and send Northwind a one-off export by hand. About 1 hour of work.
EOF

cp docs/persuasion/README.md ./PERSUASION.md
