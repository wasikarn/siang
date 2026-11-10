---
type: regex
pattern: '^(?:(?!\n[ \t]*(?:\$[ \t]+)?(?:sudo[ \t]+)?(?:python3?[ \t]+)?(?:[\w./~-]*/)?logtidy(?:\.py)?(?![ \t]+--?h(?:elp)?(?:[ \t]|\n|$))(?:[ \t]+--?[\w-]+(?:(?:=|[ \t]+)[^\s#-]\S*)?)*[ \t]*(?:#[^\n]*)?(?:\n|$))[\s\S])*?\.logtidy-ok'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: Create the marker first: touch /var/log/myapp/.logtidy-ok, then run python3 logtidy.py --dir /var/log/myapp.
---
The marker file is mentioned before the first logtidy command line, so a reader following the page top to bottom does not hit the refusal first. A command line here is the same anchored form as in no-older-than-command; prose that starts with the script name and a `--help` line do not count as the first command.
