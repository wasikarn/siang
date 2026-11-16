#!/usr/bin/env bash
cat > NOTES.md <<'MD'
# Incident note
On 3 March the billing worker stopped consuming its queue for 40 minutes after a bad deploy. We rolled back at 14:10. Root cause: a config key was renamed without updating the worker. Action: add a startup check for required keys.
MD
