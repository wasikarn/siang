---
type: regex
pattern: '\b(?:are|is|gets?|been|be) encrypted\b|(?<!not |n.t )\bencrypted (?:at rest|with AES)'
flags: i
match: not_contains
target: {source: file, path: README.md}
# must-pass: Snapshots are plain copies; they are not encrypted.
# must-pass: Snapshots aren't encrypted, so keep the target on an encrypted disk if you need that.
# must-fail: Snapshots are encrypted at rest.
# must-fail: Each snapshot is encrypted with AES-256.
---
Unsupported claim: nothing in the script encrypts anything, so the README must not assert that snapshots are encrypted.
