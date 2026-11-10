#!/usr/bin/env bash
mkdir -p samples
cat > samples/access-review.md <<'FIXTURE_EOF'
The quarterly access review is complete. Four dormant accounts were disabled; their owners have been notified. No further action is required from your team.

With thanks,
Margit
FIXTURE_EOF
cat > samples/vendor-renewal.md <<'FIXTURE_EOF'
The vendor contract renewal is delayed by one week. Legal has requested two clause changes; I have accepted both. The new signing date is Friday.

With thanks,
Margit
FIXTURE_EOF
cat > samples/expense-reports.md <<'FIXTURE_EOF'
**Action required:** submit your expense reports by Wednesday.

Finance closes the month on Thursday. Late reports will move to next month; there will be no exceptions.

With thanks,
Margit
FIXTURE_EOF
cat > draft.md <<'FIXTURE_EOF'
Hi everyone,

We're excited to share that the new incident review process goes live next week! Here's what you need to know:

**Key update:** every incident review must now be completed within 48 hours of resolution. Tomás Ortega will be coordinating the reviews, so it's a good idea to loop him in early.

Don't hesitate to reach out if you have any questions.

Best regards,
The Operations Team
FIXTURE_EOF
