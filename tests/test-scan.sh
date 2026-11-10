#!/usr/bin/env bash
# docs/humanize/scripts/scan.py finds the planted tells in tests/fixtures/humanize, finds nothing in plain
# prose, and skips frontmatter and code blocks. Run: bash tests/test-scan.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
scan="$root/docs/humanize/scripts/scan.py"
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT
fail=0
expect() {  # expect <label> <want> <<< text; a count ("0 candidate(s)") must start the summary line
  local out ok=0; out=$(python3 "$scan" - )
  if [[ "$2" =~ ^[0-9]+\ candidate ]]; then [[ "${out##*$'\n'}" == "$2"* ]] && ok=1
  else [[ "$out" == *"$2"* ]] && ok=1; fi
  if (( ok )); then echo "PASS $1"; else echo "FAIL $1: wanted '$2' in:"; echo "$out"; fail=1; fi
}
fixture() { cat "$root/tests/fixtures/humanize/$1.md"; }

expect "Thai notice: date/time"        "§56 western date/time"   <<< "$(fixture humanize-th-notice-planted)"
expect "Thai notice: ทำการ"             "§37 nominalization"      <<< "$(fixture humanize-th-notice-planted)"
expect "Thai release note: spelling"   "§31 non-standard spelling: อัพเดท" <<< "$(fixture humanize-th-spelling-planted)"
expect "Thai customer reply: apology"  "§57 apology size"        <<< "$(fixture humanize-th-cs-planted)"
expect "English prose: em dash"        "§14 em dash"             <<< "$(cat "$root/tests/fixtures/humanize/humanize-en-prose-planted.txt")"
expect "English prose: AI vocabulary"  "§7 AI vocabulary"        <<< "$(cat "$root/tests/fixtures/humanize/humanize-en-prose-planted.txt")"
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
expect "§59 Thai echo-back"            "§59"  <<< "รับทราบค่ะ คุณลูกค้าแจ้งว่าโอนแล้ว ใช่ไหมคะ"
expect "§57 stock reassurance"         "§57"  <<< "ไม่ต้องกังวลนะคะ เดี๋ยวแอดมินเช็กให้"
expect "§58 zero-width space"          "§58"  <<< "เปิด VPN​ก่อนนะ"
expect "§40 particle slip"             "§40"  <<< "ส่งสลิปได้ไหมค่ะ"
expect "§44 trailing เมื่อ"            "§44"  <<< "request ของ API จะช้าลงเกือบเท่าตัวเมื่อมีคนอัปโหลดรูปพร้อมกัน"
expect "§44 พอ-first sentence ok"     "0 candidate(s)" <<< "พอมีคนอัปโหลดรูปพร้อมกันเยอะ request ก็ช้าลง"
expect "§44 leading เมื่อ ok"          "0 candidate(s)" <<< "เมื่อมีคนอัปโหลดรูปพร้อมกัน request จะช้าลงเกือบเท่าตัว"
# Correct Thai words that contain a rule's letters must not fire (audit 2026-11-10).
expect "วันทำการ/เวลาทำการ/ที่ทำการ ok" "0 candidate(s)" <<'MD'
ระบบจะคืนเงินภายใน 3 วันทำการค่ะ
เวลาทำการ 9.00-17.00 น.
MD
expect "ที่ + ทำการ + verb still flagged" "§37 nominalization" <<< "ระบบที่ทำการติดตั้งอัตโนมัติ"
expect "§44 เมื่อไร้ still flagged"     "§44" <<< "ระบบจะล้มเมื่อไร้การเชื่อมต่อ"
expect "§44 เมื่อคืน+noun still flagged" "§44" <<< "ร้านจะคืนเงินให้เมื่อคืนสินค้าครบแล้วค่ะ"
expect "§44 เมื่อไรก็ตาม still flagged" "§44" <<< "ระบบจะแจ้งเตือนเมื่อไรก็ตามที่ CPU เกิน 80%"
expect "§44 เมื่อคืนนี้ ok"            "0 candidate(s)" <<< "ทีมจะสรุปผลที่คุยกันเมื่อคืนนี้"
expect "เมื่อไหร่/เมื่อวาน after จะ ok"  "0 candidate(s)" <<'MD'
งานนี้จะเสร็จเมื่อไหร่คะ
ทีมจะสรุปผลจากที่คุยกันเมื่อวาน
MD
expect "ชนะค่ะ/ผ้าไหมค่ะ ok"            "0 candidate(s)" <<'MD'
ทีมเราชนะค่ะ
ร้านนี้ขายผ้าไหมค่ะ
MD
expect "§31 อัพโหลด"                  "§31 non-standard spelling: อัพโหลด" <<< "ไฟล์อัพโหลดไม่ขึ้น"
expect "§31 ฟังชั่น"                   "§31 non-standard spelling: ฟังชั่น" <<< "เรียกฟังชั่นนี้ก่อน"
# Curly apostrophes, as models often emit them, still name the tell.
expect "§9 curly apostrophe"          "§9"   <<< "It’s not a refactor. It’s a rewrite."
expect "§22 curly apostrophe"         "§22"  <<< "You’re absolutely right."
expect "§28 curly apostrophe"         "§28"  <<< "Here’s the thing."
# A fence indented under a list item is still a fence: its code is protected.
expect "fence nested in a list skipped" "0 candidate(s)" <<'MD'
- Example:
    ```
    delve — code
    ```

Plain prose.
MD
expect "double-backtick inline code skipped" "0 candidate(s)" <<< 'Use ``echo `date` — output`` here.'
# One probe per rule not covered above, so a broken regex fails here.
expect "§8"   "§8"   <<< "The cache serves as a buffer."
expect "§20"  "§20"  <<< "Let me know if you need more."
expect "§23"  "§23"  <<< "We retry in order to avoid drops."
expect "§25"  "§25"  <<< "โดยสรุปแล้วระบบทำงานได้"
expect "§27"  "§27"  <<< "At its core, this is a queue."
expect "§59 English" "§59" <<< "As you know, the job runs nightly."
expect "§61"  "§61"  <<< "Some might argue this is slow."
expect "§7 Thai" "§7 Thai AI vocabulary" <<< "ทีมขอเน้นย้ำเรื่องนี้"
expect "§7 landscape" "§7 AI vocabulary (abstract sense?)" <<< "The cloud landscape changed."
expect "§33"  "§33"  <<< "นอกจากนี้ยังแก้บั๊กด้วย"
expect "§36"  "§36"  <<< "เรามุ่งมั่นพัฒนาระบบ"
expect "§32.8" "§32.8" <<< "ขอบคุณท่านลูกค้าทุกท่าน"
expect "§51"  "§51"  <<< "ในยุคปัจจุบันทุกคนใช้แอป"
expect "§19"  "§19 curly quote" <<< "He said “ship it”."
expect "§53 numeral before English"  "§53 Thai numeral before an English noun" <<< "ระบบมีสอง skill ให้ใช้"
expect "§53 numeral after another word" "§53 Thai numeral before an English noun" <<< "เคสของอีกสี่ skill รันซ้ำ"
expect "§53 Arabic numeral is fine" "0 candidate(s)" <<< "ระบบมี 2 skill ให้ใช้ และ skill อีก 4 ตัว"
# The repo's own READMEs must scan clean: they are Thai prose this tool is meant to check.
for f in README.md README.en.md; do
  out=$(python3 "$scan" "$root/$f")
  if [[ "${out##*$'\n'}" == "0 candidate(s)"* ]]; then echo "PASS $f scans clean"; else echo "FAIL $f:"; echo "$out"; fail=1; fi
done
exit "$fail"
