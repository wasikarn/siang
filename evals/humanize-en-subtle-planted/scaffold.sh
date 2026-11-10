#!/usr/bin/env bash
cat > update.md <<'FIXTURE_EOF'
Here's the thing: our nightly export kept timing out.

As you know, the export job runs on the old cron box. This PR was added to replace the cron job with a queue worker (`workers/export.py`).

It's not a refactor. It's a fix. The export now finishes in 4 minutes instead of timing out at 30.

Some might argue a queue is overkill for one job. It isn't.

That's the win.
FIXTURE_EOF
