#!/usr/bin/env bash
# Plants 5 short team updates by the user and 1 pasted vendor email (labelled inside the file as not the user's).
# Answer key:
# - Shared habits (every user sample, or at least 3): numbers always as digits, never spelled out (all 5);
#   the hedge word "probably" (01-04); opens with a past-tense verb and no subject or greeting (all 5).
#   Also no greeting, no sign-off, no exclamation marks, a flat understated last line (not graded).
#   The prompt spells out "two weeks", so the digits habit has to come from the samples.
# - One-offs, exactly one sample each, must not be copied: a "P.S." line (03), a hashtag (04).
# - Not the user's writing: 06 is CertPoint's email ("Kindly", "do not hesitate", "Rest assured",
#   "around the clock", "Best regards", an apology). Its formulas must not reach the draft.
# - The prompt supplies no apology; an incident update tempts one (and the vendor email models it).
mkdir -p samples

cat > samples/01-deploy-freeze.md <<'EOF'
Moved the deploy freeze to Thursday 18:00. 3 teams asked for it and nobody argued, which is a first.
Release train still leaves Monday. Probably on time.
Not the most exciting thing I will post this week.
EOF

cat > samples/02-pager.md <<'EOF'
Paged 4 times overnight, all for the same disk alert on build-07. Raised the threshold to 90% and wrote it up in OPS-3120.
The disk is probably fine. The alert was the problem.
Slept about as well as you would expect.
EOF

cat > samples/03-queue-migration.md <<'EOF'
Finished the queue migration at 02:10. 2 consumers lagged for 15 minutes, then caught up on their own.
No messages lost as far as we can tell. Jonas is checking the dead-letter count, which is probably 0.
Mildly anticlimactic, which is the goal.
P.S. the old cluster is off, so stop SSHing into it.
EOF

cat > samples/04-on-call.md <<'EOF'
Swapped on-call with Dev for the week of 17 Nov. The rota is updated, the calendar probably is not.
Had a 6-week run without a sev-2 going into this, so it feels a bit like tempting fate. #smallwins
EOF

cat > samples/05-ci-bill.md <<'EOF'
Cut the CI bill by 22% this month, mostly by deleting 140 runners nobody used.
Could have done this in March. Did not.
EOF

cat > samples/06-cert-renewal.md <<'EOF'
[Pasted for context. This is the vendor's email to us, not something I wrote.]

Hi team!

We sincerely apologize for the inconvenience caused by the certificate renewal issue. Kindly note that our engineers are working around the clock to make sure this never happens again!

Rest assured that your account is our top priority. Please do not hesitate to contact us with any questions.

Best regards,
CertPoint Support
EOF
