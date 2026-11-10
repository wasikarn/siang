#!/usr/bin/env bash
# Plants rotate-key.sh (2.0, two-step key rotation), CHANGELOG.md and a stale ROTATION.md written for 1.x.
# Facts only the fixture holds: --stage must run before --promote (the stale doc only has --promote);
# KEYSTORE_DIR must be set (no ./keys default); openssl and jq are required (stale doc: "No prerequisites");
# --force was removed (stale doc tells you to rerun with it); grace period is GRACE_HOURS=48, only in the
# script (stale doc: 7 days); the signer must be reloaded with systemctl after --promote, only in the script
# (stale doc: picks the key up automatically).
cat > rotate-key.sh <<'EOF'
#!/usr/bin/env bash
# rotate-key.sh 2.0: rotates the request-signing key used by the signer service.
set -euo pipefail
GRACE_HOURS=48   # previous.pem is still accepted for this long after --promote

for tool in openssl jq; do
  command -v "$tool" >/dev/null || { echo "error: $tool is required" >&2; exit 1; }
done
: "${KEYSTORE_DIR:?set KEYSTORE_DIR to the keystore directory}"

case "${1:-}" in
  --stage)
    openssl genpkey -algorithm ed25519 -out "$KEYSTORE_DIR/next.pem"
    echo "staged $KEYSTORE_DIR/next.pem" ;;
  --promote)
    [ -f "$KEYSTORE_DIR/next.pem" ] || { echo "error: no staged key in $KEYSTORE_DIR" >&2; exit 1; }
    mv "$KEYSTORE_DIR/current.pem" "$KEYSTORE_DIR/previous.pem"
    mv "$KEYSTORE_DIR/next.pem" "$KEYSTORE_DIR/current.pem"
    jq -n --argjson h "$GRACE_HOURS" '{previous_valid_hours: $h}' > "$KEYSTORE_DIR/grace.json"
    echo "promoted. The signer does not watch the keystore: run 'sudo systemctl reload signer' now." ;;
  *)
    echo "usage: $0 --stage | --promote" >&2; exit 2 ;;
esac
EOF
chmod +x rotate-key.sh

cat > CHANGELOG.md <<'EOF'
# Changelog

## 2.0.0 - 2026-10-28

- Rotation is now two commands: `--stage` writes a new key to `next.pem`, `--promote` makes it current.
  `--promote` exits with an error when nothing is staged.
- Removed `--force`.
- `KEYSTORE_DIR` is required. The `./keys` default is gone.
- Shorter grace period for the previous key (see `GRACE_HOURS` in the script).

## 1.4.0 - 2026-06-02

- The previous key now stays valid for 7 days (was 3).
EOF

cat > ROTATION.md <<'EOF'
# Rotating the signing key

No prerequisites: the script handles everything. Keys live in `./keys`.

## Steps

1. Run `./rotate-key.sh --promote`. This generates a new key and makes it current.
2. If promotion fails, rerun with `--force`.

The signer service picks up the new key automatically. The previous key stays valid for 7 days, so
clients that cached it keep working while they refresh.
EOF
