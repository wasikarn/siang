#!/usr/bin/env bash
mkdir -p bin docs
cat > bin/rotate-key <<'FIXTURE_EOF'
#!/usr/bin/env bash
# Usage: rotate-key --env <staging|prod> [--dry-run]
# Needs KEYSTORE_URL; exits 2 when it is unset. --force was removed in v2.
set -euo pipefail
env=""; dry=0
while [ $# -gt 0 ]; do
  case "$1" in
    --env) env="$2"; shift 2 ;;
    --dry-run) dry=1; shift ;;
    *) echo "unknown flag: $1" >&2; exit 64 ;;
  esac
done
[ "$env" = staging ] || [ "$env" = prod ] || { echo "usage: rotate-key --env <staging|prod> [--dry-run]" >&2; exit 64; }
[ -n "${KEYSTORE_URL:-}" ] || { echo "KEYSTORE_URL is not set" >&2; exit 2; }
if [ "$dry" = 1 ]; then echo "dry-run: would rotate $env key"; exit 0; fi
id=$(curl -fsS -X POST "$KEYSTORE_URL/rotate/$env")
echo "rotated $env key; new id: $id"
FIXTURE_EOF
chmod +x bin/rotate-key
cat > docs/rotate-key.md <<'FIXTURE_EOF'
# Key rotation

Run `rotate-key --env prod --force` to rotate the key. You should probably do a dry run first. Set KEYSTORE_URL if it complains. The old key keeps working for 24 hours, so there is no rush to update clients.
FIXTURE_EOF
