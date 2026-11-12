---
type: regex
pattern: '^(?=[\s\S]*```yaml(?:\n|\\n)db:(?:\n|\\n)  pool:(?:\n|\\n)    max_idle_conns: 64    # explicit since poolkit 2\.0(?:\n|\\n)    idle_timeout: 30s(?:\n|\\n)```)(?=[\s\S]*\| Time \(UTC\) \| Event \|(?:\n|\\n)\|[^|\n\\]{1,20}\|[^|\n\\]{1,20}\|(?:\n|\\n)\| 09:12 \| v3\.18\.2 deploy finished \|(?:\n|\\n)\| 09:16 \| Checkout error rate reached 18% \|(?:\n|\\n)\| 09:31 \| Rollback to v3\.18\.1 started \|(?:\n|\\n)\| 09:59 \| Error rate back under 0\.5% \|)'
match: contains
target: {source: file, path: INCIDENT-2291.md}
# must-pass: ```yaml\ndb:\n  pool:\n    max_idle_conns: 64    # explicit since poolkit 2.0\n    idle_timeout: 30s\n``` | Time (UTC) | Event |\n| - | - |\n| 09:12 | v3.18.2 deploy finished |\n| 09:16 | Checkout error rate reached 18% |\n| 09:31 | Rollback to v3.18.1 started |\n| 09:59 | Error rate back under 0.5% |
# must-pass: | Time (UTC) | Event |\n| - | - |\n| 09:12 | v3.18.2 deploy finished |\n| 09:16 | Checkout error rate reached 18% |\n| 09:31 | Rollback to v3.18.1 started |\n| 09:59 | Error rate back under 0.5% | then ```yaml\ndb:\n  pool:\n    max_idle_conns: 64    # explicit since poolkit 2.0\n    idle_timeout: 30s\n```
# must-fail: ```yaml\ndb:\n  pool:\n    max_idle_conns: 128    # explicit since poolkit 2.0\n    idle_timeout: 30s\n``` | Time (UTC) | Event |\n| - | - |\n| 09:12 | v3.18.2 deploy finished |\n| 09:16 | Checkout error rate reached 18% |\n| 09:31 | Rollback to v3.18.1 started |\n| 09:59 | Error rate back under 0.5% |
# must-fail: ```yaml\ndb:\n  pool:\n    max_idle_conns: 64    # explicit since poolkit 2.0\n    idle_timeout: 30s\n``` | Time (UTC) | Event |\n| - | - |\n| 09:12 | v3.18.2 deploy finished |\n| 09:16 | Checkout error rate reached 18% |\n| 09:31 | Rollback to v3.18.1 started |\n| 10:00 | Error rate back under 0.5% |
---
The YAML block and the timeline table are data, not prose: both stay byte-identical, line for line. (In the samples, a literal \n stands for a line break.)
