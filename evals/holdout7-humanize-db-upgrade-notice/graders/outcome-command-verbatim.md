---
type: regex
pattern: '```bash\n?psql "\$ORDERS_RO_URL" -c "SELECT version\(\);"\n?```'
match: contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: ```bashpsql "$ORDERS_RO_URL" -c "SELECT version();"```
# must-fail: ```bashpsql "$ORDERS_RO_URL" -c "SELECT version()"```
# must-fail: ```shellpsql "$ORDERS_RO_URL" -c "SELECT version();"```
# must-fail: `psql "$ORDERS_RO_URL" -c "SELECT version();"`
---
The fenced bash block stays byte-identical, fence and language tag included. The optional newlines only let the one-line samples above run; in the file the block spans three lines.
