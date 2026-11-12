---
type: regex
pattern: 'exit(?:s|ed)?(?: with)?(?: code| status)?[^\n]{0,40}\b4\b[^\n]{0,80}(?:lock|another run|already running)|(?:lock|another run|already running)[^\n]{0,100}(?:exit|status|code|return)[^\n]{0,30}\b4\b|^[ \t]*(?:[-*][ \t]*)?\|?[ \t]*`?4`?[ \t]*[|:][^\n]*(?:lock|another run|already running)'
match: contains
target: {source: file, path: README.md}
flags: im
# fixture: absent
# must-pass: | `4` | Another run holds `.janitor.lock`; nothing was deleted. |
# must-pass: If another run holds the lock, janitor exits with status 4.
# must-fail: If another run is still going, it exits with status 1.
# must-fail: | `1` | lock held, another run is active |
---
When another run holds `.janitor.lock` the script exits 4 (`EXIT_LOCKED`); the old README says status 1.
