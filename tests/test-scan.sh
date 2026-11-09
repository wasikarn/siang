#!/usr/bin/env bash
# skills/humanize/scripts/scan.py finds the planted tells in the eval fixtures, finds nothing in plain
# prose, and skips frontmatter and code blocks. Run: bash tests/test-scan.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
scan="$root/skills/humanize/scripts/scan.py"
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT
fail=0
expect() {  # expect <label> <want-substring> <<< text
  local out; out=$(python3 "$scan" - )
  if [[ "$out" == *"$2"* ]]; then echo "PASS $1"; else echo "FAIL $1: wanted '$2' in:"; echo "$out"; fail=1; fi
}
fixture() { (cd "$work" && bash "$root/evals/$1/scaffold.sh" >/dev/null && cat "$work/$2"); }

expect "Thai notice: date/time"        "§56 western date/time"   <<< "$(fixture humanize-th-notice-planted notice.md)"
expect "Thai notice: ทำการ"             "§37 nominalization"      <<< "$(fixture humanize-th-notice-planted notice.md)"
expect "Thai release note: spelling"   "§31 non-standard spelling: อัพเดท" <<< "$(fixture humanize-th-spelling-planted release-note.md)"
expect "Thai customer reply: apology"  "§57 apology size"        <<< "$(fixture humanize-th-cs-planted reply-draft.md)"
expect "English prose: em dash"        "§14 em dash"             <<< "$(cat "$root"/evals/humanize-en-prose-planted/scaffold.sh)"
expect "English prose: AI vocabulary"  "§7 AI vocabulary"        <<< "$(cat "$root"/evals/humanize-en-prose-planted/scaffold.sh)"
expect "plain prose: no hits"          "0 candidate(s)"          <<< "PR #412 gates 5% of traffic. On 2026-08-30 the cohort had a 3% error rate."
expect "code block and frontmatter skipped" "0 candidate(s)" <<'MD'
---
title: notes — draft
---
Plain line.
```
x = 1  # delve — not prose
```
Another `inline — code` line.
MD
exit "$fail"
