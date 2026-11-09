#!/usr/bin/env bash
mkdir -p samples
cat > samples/staging-fixed.md <<'FIXTURE_EOF'
Heyy team, quick one before the weekend, the staging box is back up and honestly it was a weird one because the disk filled with old logs and nobody noticed until the deploy failed, so I cleared them out and added a cron to rotate them and we should be fine now! 🙌 shout if anything looks off
FIXTURE_EOF
cat > samples/onboarding-doc.md <<'FIXTURE_EOF'
Heyy folks, so the new onboarding doc is live and I went through it with Sam yesterday and he found like three broken links which I fixed already, plus I added a section on getting VPN access because that keeps coming up every single time someone new joins! Have a read when you get a sec 🙌
FIXTURE_EOF
cat > samples/retro-notes.md <<'FIXTURE_EOF'
Heyy all, retro notes from today, short version:

- we're moving standup to 10:15
- Lena owns the flaky test hunt this sprint
- demo day is the last Thursday of the month

and I know the standup move is annoying for the early birds but it means the folks in Lisbon can actually join without dialling in from the train, which is a big win! 🙌
FIXTURE_EOF
cat > draft.md <<'FIXTURE_EOF'
Dear colleagues,

We are pleased to announce that the migration of customer accounts to the new billing platform has been completed. Key outcomes are as follows:

- 1,250 accounts were migrated successfully.
- Priya Raman led the migration effort.
- The legacy platform will remain available in read-only mode.

Please do not hesitate to reach out should you have any questions.

Kind regards,
Dani
FIXTURE_EOF
