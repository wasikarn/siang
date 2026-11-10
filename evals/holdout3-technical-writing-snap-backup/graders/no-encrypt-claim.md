---
type: regex
pattern: 'snap[ \t]+[-~/.$"''][^\n]*--encrypt\b|\b(?:is|are|gets?) (?!not\b|never\b)(?:\w+ )?encrypted\b'
match: not_contains
target: {source: file, path: README.md}
# must-pass: snap has no `--encrypt` option; archives are not encrypted.
# must-pass: Archives are compressed, not encrypted. Encrypt the destination yourself if you need to.
# must-fail:     bin/snap --source ~/notes --encrypt
# must-fail: The archive is encrypted with GPG using your default key.
---
snap never encrypts: there is no `--encrypt` option and the archive is a plain `.tar.zst`. The README must not show `--encrypt` in a command or say the archive is encrypted. Saying it is not encrypted is fine.
