---
type: regex
pattern: '^[ \t]*(?:\$[ \t]+)?(?:sudo[ \t]+)?(?:python3?[ \t]+)?(?:[\w./~-]*/)?logtidy(?:\.py)?(?=[^\n#]*[ \t]--older-than(?:=|[ \t]|$))(?:[ \t]+--?[\w-]+(?:(?:=|[ \t]+)[^\s#-]\S*)?)*[ \t]*(?:#[^\n]*)?$'
flags: m
match: not_contains
target: {source: file, path: README.md}
# must-pass: `--older-than` was removed in 0.3.0; use `--keep-days` instead.
# must-pass: logtidy.py --older-than was renamed to --keep-days, so logtidy.py --older-than 30 now fails.
# must-pass: python3 logtidy.py --dir /var/log/myapp --keep-days 30  # replaces the old --older-than 30
# must-pass: Older READMEs showed `python3 logtidy.py --dir /var/log/myapp --older-than 30`; that flag is gone.
# must-fail: python3 logtidy.py --dir /var/log/myapp --older-than 30
# must-fail: $ ./logtidy.py --older-than=30 --dir logs
# must-fail:     sudo python3 /opt/logtidy/logtidy.py --dir /var/log/app --older-than 7
---
No command line in the README runs logtidy with `--older-than`: 0.3.0 renamed it to `--keep-days` and argparse rejects the old name. Only a line that is a logtidy command (optional `$ `, `sudo`, `python3`, then the script and nothing but flags and their values) counts, so a migration note that names the removed flag in prose or inline code passes.
