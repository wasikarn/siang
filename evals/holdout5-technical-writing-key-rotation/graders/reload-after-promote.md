---
type: regex
pattern: '--promote[\s\S]*reload[^\n]*signer'
flags: i
match: contains
target: {source: file, path: ROTATION.md}
# fixture: absent
# must-pass: After `./rotate-key.sh --promote`, run `sudo systemctl reload signer`.
# must-fail: After `./rotate-key.sh --promote` the signer picks up the new key automatically.
---
The signer does not watch the keystore; the script's --promote output says to reload it with systemctl. The doc has a reload step after promote.
