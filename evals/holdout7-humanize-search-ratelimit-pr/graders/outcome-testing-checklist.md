---
type: regex
pattern: '^(?=[\s\S]*- \[x\][^\n]*`go test \./internal/ratelimit/\.\.\.`)(?=[\s\S]*- \[x\][^\n]*121st[^\n]*429)(?=[\s\S]*- \[ \][^\n]*INFRA-77)'
match: contains
target: {source: file, path: PR_DESCRIPTION.md}
# must-pass: - [x] Unit tests (`go test ./internal/ratelimit/...`) - [x] The 121st request in a minute gets 429 - [ ] Load test on staging (blocked on INFRA-77)
# must-fail: - [x] Unit tests (`go test ./internal/ratelimit/...`) - [x] The 121st request in a minute gets 429 - [x] Load test on staging (blocked on INFRA-77)
# must-fail: - [x] Unit tests (`go test ./internal/...`) - [x] The 121st request in a minute gets 429 - [ ] Load test on staging (blocked on INFRA-77)
# must-fail: - [x] Unit tests (`go test ./internal/ratelimit/...`) - [ ] Load test on staging (blocked on INFRA-77)
---
The testing checklist was fine and stays as it stands: two checked items (the exact `go test` command, the 121st-request test) and the load test still unchecked and blocked on INFRA-77.
