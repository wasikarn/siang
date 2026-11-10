---
type: regex
pattern: 'rotate-key\.sh\s+--stage[\s\S]*rotate-key\.sh\s+--promote'
match: contains
target: {source: file, path: ROTATION.md}
# fixture: absent
# must-pass: 1. Run `KEYSTORE_DIR=/srv/keys ./rotate-key.sh --stage`. 2. Run `./rotate-key.sh --promote`.
# must-fail: 1. Run `./rotate-key.sh --promote`. 2. If that fails, run `./rotate-key.sh --stage`.
---
In 2.0, `--promote` refuses to run unless `--stage` ran first. The doc shows the stage command before the promote command.
