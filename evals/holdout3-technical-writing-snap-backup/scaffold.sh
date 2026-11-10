#!/usr/bin/env bash
# Builds a tiny backup tool: bin/snap (tar piped to zstd, rotation by count), snap.conf with the defaults,
# and a README written for an older version. The old README uses a positional source and --target
# (now --source and --dest), says 10 archives are kept (snap.conf: 5) and /backups is the default
# (snap.conf: /var/backups/snap), documents an --encrypt flag the script never had, and never says
# zstd must be installed, though snap exits 3 without it, even on --dry-run.
set -euo pipefail
mkdir -p bin

cat > bin/snap <<'SH'
#!/usr/bin/env bash
# snap: compress a directory into a timestamped .tar.zst archive and keep only the newest N archives.
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
# shellcheck source=/dev/null
. "${SNAP_CONF:-$here/snap.conf}"

src="" dest="$SNAP_DEST" keep="$SNAP_KEEP" dry=0
while [ $# -gt 0 ]; do
  case "$1" in
    -s|--source) src=$2; shift 2 ;;
    -d|--dest) dest=$2; shift 2 ;;
    -k|--keep) keep=$2; shift 2 ;;
    -n|--dry-run) dry=1; shift ;;
    -h|--help) sed -n 2p "$0"; exit 0 ;;
    *) echo "snap: unknown option $1" >&2; exit 2 ;;
  esac
done

[ -n "$src" ] || { echo "snap: --source DIR is required" >&2; exit 2; }
[ -d "$src" ] || { echo "snap: $src is not a directory" >&2; exit 2; }
command -v zstd >/dev/null || { echo "snap: zstd not found on PATH; install it first" >&2; exit 3; }

base=$(basename "$src")
name="$base-$(date +%Y%m%d-%H%M%S).tar.zst"
if [ "$dry" = 1 ]; then
  echo "would write $dest/$name and keep the newest $keep"
  exit 0
fi

mkdir -p "$dest"
tar -C "$(dirname "$src")" -cf - "$base" | zstd -q -o "$dest/$name"
# Rotation: delete archives of this source beyond the newest $keep.
ls -1t "$dest/$base"-*.tar.zst | tail -n +$((keep + 1)) | while IFS= read -r old; do rm -- "$old"; done
echo "wrote $dest/$name"
SH
chmod +x bin/snap

cat > snap.conf <<'CONF'
# Defaults for bin/snap. Override per run with --dest / --keep, or point SNAP_CONF at another file.
SNAP_DEST=/var/backups/snap
SNAP_KEEP=5
CONF

cat > README.md <<'MD'
# snap

Snapshots a directory into a compressed archive.

## Usage

    bin/snap ~/notes --target /mnt/backup

Archives go to `/backups` unless you pass `--target`. snap keeps the 10 newest archives for each directory
and deletes older ones.

## Encryption

To protect sensitive folders, add `--encrypt`:

    bin/snap ~/notes --encrypt

The archive is encrypted with GPG using your default key.
MD
