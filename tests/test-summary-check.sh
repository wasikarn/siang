#!/usr/bin/env bash
# skills/thai-summary/scripts/summary_check.py accepts the SKILL.md example and flags each planted template defect.
# Run: bash tests/test-summary-check.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
sc="$root/skills/thai-summary/scripts/summary_check.py"
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT
fail=0
python3 - "$root/skills/thai-summary/SKILL.md" "$work/ok.md" <<'PY'
import re, sys
text = open(sys.argv[1], encoding="utf-8").read().split("## Example", 1)[1]
open(sys.argv[2], "w", encoding="utf-8").write(re.search(r"```markdown\n(.*?)```", text, re.S).group(1))
PY
expect() {  # expect <label> <check name or "clean"> <python snippet turning s into the broken summary>
  python3 -c 'import sys; s=open(sys.argv[1],encoding="utf-8").read(); open(sys.argv[2],"w",encoding="utf-8").write(eval(sys.argv[3]))' \
    "$work/ok.md" "$work/t.md" "$3"
  set +e; python3 "$sc" "$work/t.md" > "$work/out.json"; code=$?; set -e
  if [ "$2" = clean ]; then
    [ "$code" = 0 ] && echo "PASS $1" || { echo "FAIL $1: exit $code"; fail=1; }
  else
    if [ "$code" = 1 ] && grep -q "\"check\": \"$2\"" "$work/out.json"; then echo "PASS $1"; else echo "FAIL $1: exit $code, want $2"; fail=1; fi
  fi
}
expect "SKILL.md example passes"                 clean             's'
expect "dropped heading is missing"            missing-heading   's.replace("## ที่ยังค้าง","## หมายเหตุ").replace("## หมายเหตุ","")'
expect "swapped headings are out of order"     heading-order     's.replace("## ประเด็นหลัก","## @@").replace("## การตัดสินใจ","## ประเด็นหลัก").replace("## @@","## การตัดสินใจ")'
expect "added heading is extra"                extra-heading     's+"\n## ภาคผนวก\nx\n"'
expect "four-line conclusion is too long"      conclusion-length 's.replace("## ประเด็นหลัก","บรรทัดสอง\nบรรทัดสาม\nบรรทัดสี่\n\n## ประเด็นหลัก")'
expect "one key point is too few"              key-points-count  's.replace("- ลูกค้า 1 รายรอฟีเจอร์ export แต่ยอมรอได้\n","").replace("- ทีม QA ต้องการเวลาเพิ่มอีก 3 วันเพื่อ regression test\n","")'
expect "action without owner/date is bad shape" action-shape     's.replace("- มาลี — แจ้งลูกค้าเรื่องวันใหม่ — วันนี้","- แจ้งลูกค้าเรื่องวันใหม่")'
expect "over 1500 characters is too long"      too-long          's+"ก"*1600'
expect "empty section is flagged"              empty-section     's.replace("- เลื่อน release จากวันศุกร์ไปวันศุกร์หน้า (ตัดสินใจโดยหัวหน้าทีม)\n","")'
expect "H1 title is an extra heading"          extra-heading     '"# สรุปประชุม\n"+s'
expect "text before first heading is flagged"  preamble          '"เอกสารนี้พูดถึงการประชุม\n"+s'
expect "summary wrapped in a code fence"       code-fence        '"```markdown\n"+s+"```\n"'
expect "ไม่มี alone in an action section is clean"  clean   '__import__("re").sub(r"(## สิ่งที่ต้องทำต่อ\n)(?:- .*\n)+", r"\1ไม่มี\n", s)'
expect "bulleted ไม่มี in an action section is clean" clean '__import__("re").sub(r"(## สิ่งที่ต้องทำต่อ\n)(?:- .*\n)+", r"\1- ไม่มี\n", s)'
expect "ไม่มี plus a real action is bad shape" action-shape '__import__("re").sub(r"(## สิ่งที่ต้องทำต่อ\n)", r"\1- ไม่มี\n", s)'
expect "action with a dash placeholder for when is bad shape" action-shape 's.replace("- มาลี — แจ้งลูกค้าเรื่องวันใหม่ — วันนี้","- มาลี — แจ้งลูกค้าเรื่องวันใหม่ — -")'
expect "numbered key points count like bullets" clean '__import__("re").sub(r"- (migration|ลูกค้า|ทีม QA)", lambda m: "1. "+m.group(1), s)'
expect "numbered action with no owner is bad shape" action-shape 's.replace("- มาลี — แจ้งลูกค้าเรื่องวันใหม่ — วันนี้","1. — แจ้งลูกค้าเรื่องวันใหม่ — วันนี้")'
expect "numbered ไม่มี alone in an action section is clean" clean '__import__("re").sub(r"(## สิ่งที่ต้องทำต่อ\n)(?:- .*\n)+", r"\g<1>1. ไม่มี\n", s)'
expect "quoted ไม่มี alone in an action section is clean" clean '__import__("re").sub(r"(## สิ่งที่ต้องทำต่อ\n)(?:- .*\n)+", lambda m: m.group(1)+"- "+chr(34)+"ไม่มี"+chr(34)+"\n", s)'
expect "a UTF-8 byte order mark does not break the first heading" clean '"\ufeff"+s'
expect "plus-sign key points count like bullets" clean 's.replace("- migration","+ migration").replace("- ลูกค้า","+ ลูกค้า").replace("- ทีม QA ต้องการ","+ ทีม QA ต้องการ")'
expect "a nested sub-bullet is not a key point" key-points-count 's.replace("## ประเด็นหลัก\n- migration ล้มเหลวบน staging 2 ครั้งจาก 3 ครั้ง\n- ลูกค้า 1 รายรอฟีเจอร์ export แต่ยอมรอได้\n- ทีม QA ต้องการเวลาเพิ่มอีก 3 วันเพื่อ regression test","## ประเด็นหลัก\n- ข้อเดียว\n  - รายละเอียดย่อย\n  - อีกอัน")'
expect "ไม่มี beside a decision is flagged" none-with-content 's.replace("## การตัดสินใจ\n","## การตัดสินใจ\n- ไม่มี\n")'
expect "ไม่มี beside an open question is flagged" none-with-content 's.replace("## ที่ยังค้าง\n","## ที่ยังค้าง\n- ไม่มี\n")'
printf 'ok\n\xe0\xff\n' > "$work/bin.md"  # bytes that are not UTF-8
set +e; python3 "$sc" "$work/bin.md" > "$work/out.json" 2> "$work/err.txt"; code=$?; set -e
if [ "$code" = 2 ] && ! grep -q Traceback "$work/err.txt"; then echo "PASS non-UTF-8 input exits 2 without a traceback"; else echo "FAIL non-UTF-8 input: exit $code"; fail=1; fi
printf 'ok\n\xe0\xff\n' | python3 "$sc" - > "$work/out.json" 2> "$work/err.txt" && code=0 || code=$?
if [ "$code" = 2 ] && ! grep -q Traceback "$work/err.txt"; then echo "PASS non-UTF-8 on stdin exits 2 without a traceback"; else echo "FAIL non-UTF-8 on stdin: exit $code"; fail=1; fi
python3 "$sc" - < "$work/ok.md" > "$work/out.json" && code=0 || code=$?
if [ "$code" = 0 ]; then echo "PASS the SKILL.md example is clean on stdin"; else echo "FAIL stdin example: exit $code"; fail=1; fi
exit $fail
