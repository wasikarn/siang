---
type: regex
pattern: '```yaml\n?search:\n?  rate_limit:\n?    enabled: false\n?    requests_per_minute: 120\n?    burst: 30\n?```'
match: contains
target: {source: file, path: PR_DESCRIPTION.md}
# must-pass: ```yamlsearch:  rate_limit:    enabled: false    requests_per_minute: 120    burst: 30```
# must-fail: ```yamlsearch:    rate_limit:        enabled: false        requests_per_minute: 120        burst: 30```
# must-fail: ```yamlsearch:  rate_limit:    enabled: off    requests_per_minute: 120    burst: 30```
# must-fail: ```ymlsearch:  rate_limit:    enabled: false    requests_per_minute: 120    burst: 30```
---
The config block stays byte-identical: fence, language tag, two-space indentation and values. The optional newlines only let the one-line samples above run; in the file each key sits on its own line, and a change of indentation still fails.
