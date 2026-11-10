---
type: regex
pattern: '^(?:(?!\n[ \t]*(?:\$[ \t]+)?(?:bash[ \t]+)?(?:[\w./~-]*/)?assetsync(?![ \t]+--?h(?:elp)?(?:[ \t]|\n|$))(?:[ \t]+--?[\w-]+(?:(?:=|[ \t]+)[^\s#-]\S*)?)*[ \t]*(?:#[^\n]*)?(?:\n|$))[\s\S])*?ASSETSYNC_TARGET'
match: contains
target: {source: file, path: docs/howto-sync-assets.md}
# fixture: absent
# must-pass: Set it first with export ASSETSYNC_TARGET=deploy@host:/srv/www, then run bin/assetsync --dry-run.
---
`ASSETSYNC_TARGET` is mentioned before the first assetsync command line, or on that line as an env prefix (`ASSETSYNC_TARGET=... bin/assetsync`), so a reader going top to bottom does not hit the error first. A command line is the same anchored form as in no-source-command, without the env prefix; prose that starts with the script name and a `--help` line do not count.
