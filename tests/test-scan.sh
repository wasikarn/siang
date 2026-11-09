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
expect "§7 siang additions"           "§7 AI vocabulary"        <<< "We will leverage the cache for stakeholders."
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
# §56 is for user-facing Thai: colon times in English or internal Thai B are correct; AM/PM and slash dates stay flagged.
expect "bare colon times not flagged"  "0 candidate(s)" <<'MD'
The job failed at 09:40.
payment-worker ค้างตอน 09:40
Deploy window is 14:30 UTC.
MD
expect "slash date still flagged"      "§56 western date/time"   <<< "Deploy window, see 10/12/2026."
expect "AM/PM still flagged"           "§56 western date/time"   <<< "ปิดระบบเวลา 1:00 AM"
# §37: ทำการ + an English verb is normal dev Thai; ได้ทำการ and การดำเนินการ still fire.
expect "ทำการ + English verb not flagged" "0 candidate(s)"     <<< "ทำการ deploy service ใหม่"
expect "ได้ทำการ still flagged"         "§37 nominalization"      <<< "ทีมได้ทำการแก้ไขแล้ว"
expect "การดำเนินการ still flagged"     "§37 nominalization"      <<< "การดำเนินการนี้ใช้เวลานาน"
# Protected regions stay byte-identical, so they are not scanned and their dashes are not counted.
expect "4-backtick fence not closed by \`\`\`" "0 candidate(s)" <<'MD'
````markdown
```
delve — inside outer fence
````
MD
expect "blockquote skipped"            "0 candidate(s)"          <<< "> delve — unchanged quotation"
expect "indented code skipped"         "0 candidate(s)" <<'MD'
Plain line.

    example = 'delve — code'
	tabbed = 'delve — code'
MD
expect "em dashes count prose only"    "1 candidate(s); em dashes: 1" <<'MD'
Prose line — with a dash.
> quoted — dash

    code — dash
````
```
fenced — dash
````
MD
exit "$fail"
