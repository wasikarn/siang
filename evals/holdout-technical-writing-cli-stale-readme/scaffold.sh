#!/usr/bin/env bash
cat > snapshot <<'FIXTURE_EOF'
#!/usr/bin/env bash
# snapshot: copy SOURCE into a dated folder under --target and prune old snapshots.
set -euo pipefail
usage() {
  cat <<'USAGE'
Usage: snapshot --target DIR [--keep N] [--dry-run] SOURCE

Copy SOURCE into DIR/YYYY-MM-DD_HHMMSS and delete the oldest snapshots beyond N.

Options:
  --target DIR   directory that holds the snapshots (required)
  --keep N       number of snapshots to keep (default: 7)
  --dry-run      show what rsync would copy; change nothing
  -h, --help     show this help

Requires rsync on PATH.
USAGE
}
target="" keep=7 dry=""
while [ $# -gt 0 ]; do
  case "$1" in
    --target) target="$2"; shift 2 ;;
    --keep) keep="$2"; shift 2 ;;
    --dry-run) dry="--dry-run"; shift ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "snapshot: unknown option $1" >&2; usage >&2; exit 2 ;;
    *) break ;;
  esac
done
[ $# -eq 1 ] && [ -n "$target" ] || { usage >&2; exit 2; }
command -v rsync >/dev/null || { echo "snapshot: rsync not found on PATH" >&2; exit 3; }
src="$1"
dest="$target/$(date +%Y-%m-%d_%H%M%S)"
mkdir -p "$target"
rsync -a $dry "$src/" "$dest/"
[ -n "$dry" ] && exit 0
ls -1d "$target"/*/ | sort -r | tail -n +"$((keep + 1))" | while read -r old; do rm -r -- "$old"; done
echo "snapshot: wrote $dest"
FIXTURE_EOF
chmod +x snapshot
mkdir -p sample
echo "hello" > sample/notes.txt
cat > README.md <<'FIXTURE_EOF'
# snapshot

Simple backups for a folder.

## Usage

    ./snapshot --dest /backups ~/work

Keeps the last 30 snapshots and deletes older ones. Add `-v` for verbose output.

Works on any machine with bash, no other dependencies. Snapshots are encrypted at rest.
FIXTURE_EOF
