---
type: regex
pattern: '^[ \t]*(?:\$[ \t]+)?(?:[A-Za-z_]\w*=\S*[ \t]+)*(?:bash[ \t]+)?(?:[\w./~-]*/)?assetsync(?=[^\n#]*[ \t]--source(?:=|[ \t]|$))(?:[ \t]+--?[\w-]+(?:(?:=|[ \t]+)[^\s#-]\S*)?)*[ \t]*(?:#[^\n]*)?$'
flags: m
match: not_contains
target: {source: file, path: docs/howto-sync-assets.md}
# must-pass: `--source` was renamed to `--src` in 2.0.0; `bin/assetsync --source public` now exits with "unknown option".
# must-pass: bin/assetsync --source was renamed to --src, so update old scripts.
# must-pass: bin/assetsync --src dist --dry-run   # formerly --source
# must-pass: Older docs used --source: bin/assetsync --source public no longer works.
# must-fail: bin/assetsync --source public
# must-fail: $ ASSETSYNC_TARGET=deploy@assets:/srv/www ./bin/assetsync --dry-run --source=dist
# must-fail:     bash bin/assetsync --source build --bwlimit 200
---
No command line in the how-to runs assetsync with `--source`: 2.0.0 renamed it to `--src` and the script exits 2 on an unknown option. Only a line that is an assetsync command (optional `$ `, env assignments, `bash`, then the script and nothing but flags and their values) counts, so a migration note naming the old flag in prose or inline code passes.
