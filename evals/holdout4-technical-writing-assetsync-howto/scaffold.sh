#!/usr/bin/env bash
# Builds a tiny bash CLI, bin/assetsync, that pushes built assets to a host with rsync, its config
# assetsync.conf, a changelog, and a stale how-to at docs/howto-sync-assets.md.
# Facts in the code: rsync must be installed, ASSETSYNC_TARGET must be set (user@host:/path),
# --src defaults to dist (SRC in assetsync.conf), --bwlimit defaults to 500 KB/s (BWLIMIT),
# -n/--dry-run exists, and remote files are deleted only with --delete (off by default).
# --source was renamed to --src in 2.0.0. The how-to is wrong on the flag, the default source
# (public) and claims --delete is always on.
set -euo pipefail
mkdir -p bin docs

cat > bin/assetsync <<'SH'
#!/usr/bin/env bash
# Push built static assets to the asset host with rsync.
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
. "$here/assetsync.conf"

src=$here/$SRC
bwlimit=$BWLIMIT
dry=()
del=()

usage() { echo "usage: assetsync [--src DIR] [--bwlimit KBPS] [-n|--dry-run] [--delete]"; }

while [ $# -gt 0 ]; do
  case $1 in
    --src) src=$2; shift 2 ;;
    --src=*) src=${1#*=}; shift ;;
    --bwlimit) bwlimit=$2; shift 2 ;;
    --bwlimit=*) bwlimit=${1#*=}; shift ;;
    -n|--dry-run) dry=(--dry-run); shift ;;
    --delete) del=(--delete); shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "assetsync: unknown option $1" >&2; usage >&2; exit 2 ;;
  esac
done

command -v rsync >/dev/null || { echo "assetsync: rsync is not installed" >&2; exit 1; }
: "${ASSETSYNC_TARGET:?set ASSETSYNC_TARGET to user@host:/path}"

rsync -az --bwlimit="$bwlimit" ${dry[@]+"${dry[@]}"} ${del[@]+"${del[@]}"} "$src/" "$ASSETSYNC_TARGET"
SH
chmod +x bin/assetsync

cat > assetsync.conf <<'CONF'
# Defaults for bin/assetsync. Paths are relative to the repo root.
SRC=dist
BWLIMIT=500   # KB/s
CONF

cat > CHANGELOG.md <<'MD'
# Changelog

## 2.0.0
- `--source` is renamed to `--src`.
- Defaults moved into `assetsync.conf`.

## 1.4.0
- Added `-n` / `--dry-run`.
MD

cat > docs/howto-sync-assets.md <<'MD'
# How to sync assets to the asset host

Run the sync from the repo root:

```
bin/assetsync --source public
```

The default source is `./public`. Remote files that are missing locally are always removed (`--delete` is on by default), so the host mirrors your build exactly.
MD
