#!/usr/bin/env bash
# Plants relay.py (POSTs spool/*.json to $RELAY_URL, signed with $RELAY_SECRET) and a stale README.md.
# Truths only the code or a real run shows: --retries defaults to 2 (README: 5), a failed delivery
# exits 6 (README: 1) and moves the event to spool/dead, RELAY_SECRET is required (README names only
# RELAY_URL; missing config exits 78), --insecure is gone (argparse exit 2), --dead-dir exists only in
# code, a dry run ends with "relay: N event(s) ready, 0 sent (dry run)", and the staging receiver the
# README names was retired with no replacement URL recorded here.
# spool/ holds 3 events, so the dry run prints "relay: 3 event(s) ready, 0 sent (dry run)".
set -euo pipefail

cat > relay.py <<'EOF'
#!/usr/bin/env python3
"""Forward spooled webhook events (*.json) to $RELAY_URL, signed with $RELAY_SECRET."""
import argparse
import hashlib
import hmac
import os
import shutil
import sys
import time
import urllib.request

EXIT_OK, EXIT_DELIVERY_FAILED, EXIT_CONFIG = 0, 6, 78

# The staging receiver (staging-hooks.example.com) was retired in the March platform move.
# Its replacement URL was never written down here; ask the platform team.


def post(url, body, signature, timeout):
    req = urllib.request.Request(url, data=body, method="POST", headers={
        "Content-Type": "application/json", "X-Relay-Signature": signature})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.status


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--spool", default="spool", help="directory of *.json events (default: %(default)s)")
    p.add_argument("--retries", type=int, default=2, help="extra attempts per event (default: %(default)s)")
    p.add_argument("--timeout", type=float, default=5.0, help="seconds per request (default: %(default)s)")
    p.add_argument("--dead-dir", help="where undeliverable events are moved (default: SPOOL/dead)")
    p.add_argument("--dry-run", action="store_true", help="print what would be sent, send nothing")
    a = p.parse_args()

    url, secret = os.environ.get("RELAY_URL"), os.environ.get("RELAY_SECRET")
    missing = [n for n, v in (("RELAY_URL", url), ("RELAY_SECRET", secret)) if not v]
    if missing:
        print("relay: missing environment variable(s): " + ", ".join(missing), file=sys.stderr)
        return EXIT_CONFIG

    dead = a.dead_dir or os.path.join(a.spool, "dead")
    events = sorted(f for f in os.listdir(a.spool) if f.endswith(".json"))
    sent = failed = 0
    for name in events:
        path = os.path.join(a.spool, name)
        with open(path, "rb") as fh:
            body = fh.read()
        sig = "sha256=" + hmac.new(secret.encode(), body, hashlib.sha256).hexdigest()
        if a.dry_run:
            print(f"would POST {name} ({len(body)} bytes) to {url}")
            continue
        for attempt in range(a.retries + 1):
            try:
                post(url, body, sig, a.timeout)
                os.remove(path)
                sent += 1
                break
            except OSError as e:  # URLError and HTTPError are OSError subclasses
                print(f"relay: {name} attempt {attempt + 1} failed: {e}", file=sys.stderr)
                time.sleep(0.2)
        else:
            os.makedirs(dead, exist_ok=True)
            shutil.move(path, os.path.join(dead, name))
            failed += 1

    if a.dry_run:
        print(f"relay: {len(events)} event(s) ready, 0 sent (dry run)")
        return EXIT_OK
    print(f"relay: {sent} sent, {failed} failed, failed events moved to {dead}")
    return EXIT_DELIVERY_FAILED if failed else EXIT_OK


if __name__ == "__main__":
    sys.exit(main())
EOF
chmod +x relay.py

cat > README.md <<'EOF'
# relay

Forwards queued webhook events from `spool/` to the receiver.

## Setup

Set `RELAY_URL` to the receiver endpoint. Use the staging receiver,
`https://staging-hooks.example.com/in`, for testing.

## Run

    RELAY_URL=https://hooks.example.com/in python3 relay.py

Options:

- `--spool DIR`: event directory (default: `spool`)
- `--retries N`: attempts per event (default: 5)
- `--insecure`: skip TLS certificate checks (for staging receivers)
- `--dry-run`: show what would be sent

## Testing against staging

1. Run `RELAY_URL=https://staging-hooks.example.com/in python3 relay.py --insecure --dry-run`.
2. Check the receiver logs.

Exit status is 0 on success and 1 if any event could not be delivered. Undelivered events stay in
`spool/` and are picked up on the next run.
EOF

mkdir -p spool
cat > spool/evt-1001.json <<'EOF'
{"id": "evt-1001", "type": "invoice.paid", "amount": 129.00, "currency": "EUR"}
EOF
cat > spool/evt-1002.json <<'EOF'
{"id": "evt-1002", "type": "invoice.refunded", "amount": 40.00, "currency": "EUR"}
EOF
cat > spool/evt-1003.json <<'EOF'
{"id": "evt-1003", "type": "customer.updated", "customer": "cus_7781"}
EOF
