---
type: regex
pattern: '(?:^\s*(?:\d+[.)]|[-*])?\s*|[.;:,]\s+)(?:[Rr]e-?run|[Rr]etry|[Rr]un|[Pp]ass|[Aa]dd|[Uu]se|[Tt]ry)\b(?![^.;,\n]*(?:instead|rather than|without))[^.;,\n]*--force'
flags: m
match: not_contains
target: {source: file, path: ROTATION.md}
# must-pass: `--force` was removed in 2.0. If promotion fails, run `./rotate-key.sh --stage` first.
# must-pass: Do not use `--force`; scripts that still pass `--force` get a usage error.
# must-pass: Use `--stage` instead of `--force`.
# must-fail: 2. If promotion fails, rerun with `--force`.
# must-fail: - Retry with --force.
---
--force was removed in 2.0. The doc never tells the reader to run, rerun or pass it.
