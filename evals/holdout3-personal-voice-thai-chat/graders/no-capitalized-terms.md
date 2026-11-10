---
type: regex
pattern: '\b(?:Deploy|Rollback|Staging|Hotfix|Production|Environment)\b'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: deploy hotfix บน staging แล้วนะ
# must-fail: ทำการ Deploy Hotfix บน Staging
---
None of the draft's title-cased terms (Deploy, Rollback, Staging, Hotfix, Production Environment) may stay; Nok never capitalizes them.
