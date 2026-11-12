---
type: regex
pattern: '^(?=[\s\S]*?(?:^|[\s*-])blocking:)(?=[\s\S]*?(?:^|[\s*-])q:)'
match: contains
target: {source: file, path: draft.md}
# fixture: absent
# must-pass: blocking: `client/retry.go:58` could we cap the backoff? q: where do 3 attempts come from?
# must-pass: - blocking: x. - q: y?
# must-fail: Blocking: `client/retry.go:58` could we cap the backoff? Question: where do 3 attempts come from?
# must-fail: **Blocking.** On line 58 of client/retry.go, you must put a ceiling on the backoff.
---
Shared habit (all five user samples): each point opens with a lowercase label, `blocking:`, `nit:` or `q:`. The prompt says "Blocking." and "Question."; the draft uses `blocking:` and `q:`. Case-sensitive.
