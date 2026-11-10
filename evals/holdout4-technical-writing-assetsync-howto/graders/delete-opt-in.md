---
type: regex
pattern: '--delete(?![\w-])[^\n]{0,120}(?:off by default|opt[- ]?in|optional|only (?:when|if)|unless|not (?:on|enabled|the default|set|used|passed)|disabled|if you (?:pass|add|give))|(?:\bnot\b|\bnever\b|n.t\b|\bonly\b|\bunless\b|\bwithout\b|\bnothing\b|\bno\b|\bkept\b|\bleft\b|opt[- ]?in)[^\n]{0,120}--delete(?![\w-])'
flags: i
match: contains
target: {source: file, path: docs/howto-sync-assets.md}
# fixture: absent
# must-pass: Remote files are never deleted unless you pass `--delete`.
# must-pass: `--delete` is off by default: add it to remove remote files that are gone locally.
# must-pass: By default nothing on the host is removed; add --delete for an exact mirror.
# must-pass: | `--delete` | off | Also delete remote files that no longer exist in the source (opt-in) |
# must-fail: Remote files that are missing locally are always removed (`--delete` is on by default), so the host mirrors your build exactly.
---
rsync only gets `--delete` when the reader passes it, so by default files on the host that are gone locally stay. The how-to must say deletion is opt-in (any wording) instead of the stale "always removed".
