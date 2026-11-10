---
type: regex
pattern: '--source\b|(?:^|\s)-s[ \t]+[~/.$]'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass:     bin/snap --source ~/notes
# must-pass:     ./bin/snap -s ~/notes -d /mnt/backup
# must-fail:     bin/snap ~/notes --target /mnt/backup
---
The directory to back up is passed with `--source` (or `-s`); snap exits 2 without it. The old README passed it as a bare positional argument, which snap rejects as an unknown option.
