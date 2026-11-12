---
type: regex
pattern: '^(?=[\s\S]*pg-orders-prod-01)(?=[\s\S]*OPS-2291)(?=[\s\S]*#db-maint\b)(?=[\s\S]*พิมพ์ชนก)'
match: contains
target: {source: file, path: db-upgrade-notice.md}
# must-pass: cluster `pg-orders-prod-01` (OPS-2291) ติดต่อคุณพิมพ์ชนกที่ #db-maint
# must-fail: cluster pg-orders-prod (OPS-2291) ติดต่อคุณพิมพ์ชนกที่ #db-maint
# must-fail: cluster pg-orders-prod-01 (OPS-2291) ติดต่อ on-call DBA ที่ #db-maint
---
Identifiers stay exact: the cluster `pg-orders-prod-01`, ticket OPS-2291, the #db-maint channel, and the on-call contact, คุณพิมพ์ชนก.
