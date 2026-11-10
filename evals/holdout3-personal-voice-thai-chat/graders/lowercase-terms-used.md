---
type: regex
pattern: '\b(?:deploy|rollback|staging|hotfix|prod)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: วิภา rollback ให้แล้ว
# must-fail: วิภา Rollback ให้แล้ว
---
Nok writes English tech terms in lowercase inside Thai sentences (deploy, rollback, staging, hotfix, prod). The draft only has capitalized forms, so keeping its wording fails; a rewrite in Nok's voice keeps at least one term in lowercase English.
