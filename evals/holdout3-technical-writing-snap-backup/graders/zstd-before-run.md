---
type: regex
pattern: '^(?:(?!snap[ \t]+[-~/.$"''])[\s\S])*?\bzstd\b'
match: contains
target: {source: file, path: README.md}
# fixture: absent
# must-pass: Install zstd first (brew install zstd).    bin/snap --source ~/notes
# must-fail:     bin/snap --source ~/notes    Needs zstd on PATH.
---
snap exits 3 when `zstd` is not on PATH, even with `--dry-run`, so the README must name zstd as a prerequisite before the first command that runs snap. A mention only after the first command fails: a reader following the steps in order hits the error first.
