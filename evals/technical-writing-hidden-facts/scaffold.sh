#!/usr/bin/env bash
mkdir -p bin docs assets
printf 'a' > assets/logo.png; printf 'b' > assets/app.css; printf 'c' > assets/app.js
printf '' > .sync.lock
cat > bin/sync-assets <<'FIXTURE_EOF'
#!/usr/bin/env bash
# Usage: sync-assets --bucket NAME [--prefix P] [--dry-run]
# Exit codes: 0 ok, 2 missing tool or flag, 3 lock held (.sync.lock exists), 64 unknown flag.
set -euo pipefail
bucket=""; prefix=""; dry=0
while [ $# -gt 0 ]; do
  case "$1" in
    --bucket) bucket="$2"; shift 2 ;;
    --prefix) prefix="$2"; shift 2 ;;
    --dry-run) dry=1; shift ;;
    *) echo "unknown flag: $1" >&2; exit 64 ;;
  esac
done
command -v jq >/dev/null || { echo "jq is required" >&2; exit 2; }
[ -n "$bucket" ] || { echo "--bucket is required" >&2; exit 2; }
[ ! -e .sync.lock ] || { echo "locked: remove .sync.lock if no sync is running" >&2; exit 3; }
n=$(ls assets | wc -l | tr -d ' ')
if [ "$dry" = 1 ]; then echo "dry-run: would upload $n files to s3://$bucket/$prefix"; exit 0; fi
touch .sync.lock
aws s3 sync assets "s3://$bucket/$prefix"
rm .sync.lock
FIXTURE_EOF
chmod +x bin/sync-assets
cat > docs/sync-assets.md <<'FIXTURE_EOF'
# Asset sync

Run `sync-assets --bucket-name my-bucket` to upload the assets folder. No lock handling is needed. Uploads are encrypted at rest.
FIXTURE_EOF
