---
type: regex
pattern: 'ASSETSYNC_TARGET'
match: contains
target: {source: file, path: docs/howto-sync-assets.md}
# fixture: absent
# must-pass: export ASSETSYNC_TARGET=deploy@assets.example.com:/srv/www
---
The script stops with "set ASSETSYNC_TARGET to user@host:/path" when the variable is unset, so the how-to must tell the reader to set it.
