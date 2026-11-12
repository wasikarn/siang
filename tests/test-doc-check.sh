#!/usr/bin/env bash
# docs/document-review/doc_check.py finds the planted mechanical defects in a small SOP, stays quiet on a
# clean one, and skips code blocks. Run: bash tests/test-doc-check.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
dc="$root/docs/document-review/doc_check.py"
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT
fail=0
check() {  # check <label> <python expression over j (parsed JSON)>
  if python3 -c 'import json,sys; j=json.load(open(sys.argv[1])); sys.exit(0 if eval(sys.argv[2]) else 1)' "$work/out.json" "$2"; then
    echo "PASS $1"; else echo "FAIL $1: $2"; fail=1; fi
}
has() { echo "any(f['check']=='$1' and $2 for f in j['findings'])"; }

cat > "$work/sop.md" <<'MD'
# SOP: restore the orders database

Owner: data-platform. Revision: 2026-02-30.

## 1. Purpose

Restore the orders database from the nightly snapshot (NS). Uses the HSM key.

## 2. Prerequisites

Access to the `backup-ops` role. For the lock steps, see section 7. Details in [the notes](#no-such-heading).

## 4. Procedure

1. Stop the app: `systemctl stop orders-app`.
2. Load the settings with `restore --config restore.conf`.
3. Wait 30 minutes for the replica to drain.
5. Create `restore.conf`; then repeat step 9.
6. After the 30 s wait, start the app. Retry with a timeout 45.
MD
python3 "$dc" "$work/sop.md" --sections "Purpose,Procedure,Rollback" > "$work/out.json"
check "section 7 reference is unresolved"        "$(has xref "'section 7' in f['detail']")"
check "step 9 reference is unresolved"           "$(has xref "'step 9' in f['detail']")"
check "dead anchor is unresolved"                "$(has xref "'#no-such-heading' in f['detail']")"
check "heading 4 after 2 is flagged"             "$(has heading-number "f['quote'].startswith('4 ')")"
check "list skips from 3 to 5"                   "$(has list-number "'item 5 follows 3' in f['detail']")"
check "30 minutes vs 30 s conflict"              "$(has quantity-conflict "'wait' in f['detail']")"
check "timeout 45 has no unit"                   "$(has duration-no-unit "'timeout 45' in f['detail']")"
check "HSM acronym never expanded"               "$(has acronym "f['quote']=='HSM'")"
check "NS in parentheses is not an acronym hit"  "not any(f['check']=='acronym' and f['quote']=='NS' for f in j['findings'])"
check "2026-02-30 is not a real date"            "$(has date "'2026-02-30' in f['detail']")"
check "missing Rollback section"                 "$(has section "f['quote']=='Rollback'")"

cat > "$work/clean.md" <<'MD'
# Backup runbook

## 1. Purpose

Keep a copy of the database (DB) for 90 days.

## 2. Procedure

1. Wait 30 minutes for the replica to drain.
2. Start the job; see step 1 and section 1.
3. After the 30 min wait, check the log at [notes](#1-purpose).

```
wait 5 and see section 9 and 2026-13-45 and 12 GB
```
MD
python3 "$dc" "$work/clean.md" --sections "Purpose,Procedure" > "$work/out.json"
check "clean document has no findings"           "j['findings'] == []"

printf 'Revised 2026-10-02. Reviewed 10/02/2026.\n' > "$work/dates.md"
python3 "$dc" "$work/dates.md" > "$work/out.json"
check "two date formats in one document"         "$(has date "'more than one date format' in f['detail']")"

printf '1. a\n1. b\n1. c\n' > "$work/lazy.md"
python3 "$dc" "$work/lazy.md" > "$work/out.json"
check "lazy numbering (all 1.) is accepted"      "not any(f['check']=='list-number' for f in j['findings'])"

printf 'Revised 2026-10-02. Reviewed 3 May 2026.\n' > "$work/dates2.md"
python3 "$dc" "$work/dates2.md" > "$work/out.json"
check "ISO and month-name dates are mixed"       "$(has date "'more than one date format' in f['detail']")"
printf 'Revised 2026-10-02. Reviewed 3 MAY 2026. Our CAFÉ menu.\n' > "$work/dates3.md"
python3 "$dc" "$work/dates3.md" > "$work/out.json"
check "all-caps month name is a date"            "$(has date "'more than one date format' in f['detail']")"
check "CAFÉ is not the acronym CAF"              "not any(f['check']=='acronym' and f['quote'].startswith('CAF') for f in j['findings'])"

# ordinary words are not month names; decimals and thousands keep their unit; a nested list returning to the outer
# level continues it; Thai and inline-code headings make working anchors; a year heading is not section 2026;
# "Section 3: Scope" resolves "see section 3"; an acronym glued to Thai text is still found
cat > "$work/fp.md" <<'MD'
# Runbook

Revised 2026-10-02.

## 2026 roadmap

## Section 3: Scope

## Run `deploy`

## ขั้นตอน

1. Step 2 may fail; keep 3 decimals and 2 separate copies.
   1. Wait 1.5 seconds.
   2. Retry every 10,000 requests.
2. See section 3, [deploy](#run-deploy) and [ขั้นตอน](#ขั้นตอน).
3. ใช้ APIที่มีอยู่
MD
python3 "$dc" "$work/fp.md" > "$work/out.json"
check "may/decimals/separate are not dates"      "not any(f['check']=='date' for f in j['findings'])"
check "1.5 seconds and 10,000 requests have units" "not any(f['check']=='duration-no-unit' for f in j['findings'])"
check "nested list back to outer level is fine"  "not any(f['check']=='list-number' for f in j['findings'])"
check "Thai and inline-code anchors resolve"     "not any('anchor' in f['detail'] for f in j['findings'])"
check "year heading is not a section number"     "not any(f['check']=='heading-number' and f['quote'].startswith('2026') for f in j['findings'])"
check "Section 3 heading resolves section 3"     "not any('section 3' in f['detail'] for f in j['findings'])"
check "acronym next to Thai is found"            "$(has acronym "f['quote']=='API'")"

printf '1. a\n   1. b\n   3. c\n2. d\n' > "$work/nest.md"
python3 "$dc" "$work/nest.md" > "$work/out.json"
check "a skip inside a nested list is flagged"   "$(has list-number "'item 3 follows 1' in f['detail']")"

printf 'Wait 1,500 ms for the lock.\n\nWait 500 ms for the lock.\n\nThen wait 1.5 s for the lock.\n' > "$work/thou.md"
python3 "$dc" "$work/thou.md" > "$work/out.json"
check "1,500 ms vs 500 ms is a conflict"         "$(has quantity-conflict "'1,500 ms' in f['detail'] and '500 ms' in f['detail'].replace('1,500 ms', '')")"
check "1,500 ms equals 1.5 s"                    "not any(f['check']=='quantity-conflict' and '1.5 s' in f['detail'] and '1,500 ms' in f['detail'] for f in j['findings'])"
printf '# A\n\n## Section 1: Scope\n\n## Section 1: Rules\n\n## Section 4: Notes\n\n## 5. Section 9 rules\n\nSee section 9.\n' > "$work/secnum.md"
python3 "$dc" "$work/secnum.md" > "$work/out.json"
check "repeated Section 1 heading is flagged"    "$(has heading-number "f['quote'].startswith('1 ')")"
check "Section 9 inside a numbered title is not a section" "$(has xref "'section 9' in f['detail']")"
printf 'Revised 2026-10-02. Reviewed 3 jan 2026.\n' > "$work/lowmonth.md"
python3 "$dc" "$work/lowmonth.md" > "$work/out.json"
check "lowercase month with a year is a date"    "$(has date "'more than one date format' in f['detail']")"
printf 'Reviewed 3 MAY 2026.\n' > "$work/capmonth.md"
python3 "$dc" "$work/capmonth.md" > "$work/out.json"
check "an all-caps month is not an acronym"      "not any(f['check']=='acronym' for f in j['findings'])"

printf '# X\n\n## Procedure\n\n## Purpose\n' > "$work/order.md"
python3 "$dc" "$work/order.md" --sections "Purpose,Procedure" > "$work/out.json"
check "sections out of order are flagged"        "$(has section "'out of the required order' in f['detail']")"

rc=0; python3 "$dc" "$work/missing.md" > /dev/null 2>"$work/err" || rc=$?
if [ "$rc" -eq 1 ] && grep -q "cannot read" "$work/err"; then echo "PASS missing file exits 1 with a message"
else echo "FAIL missing file: exit $rc, $(cat "$work/err")"; fail=1; fi
printf '\xff\xfe bad bytes\n' > "$work/latin1.md"
rc=0; python3 "$dc" "$work/latin1.md" > /dev/null 2>"$work/err" || rc=$?
if [ "$rc" -eq 1 ] && grep -q "cannot read" "$work/err"; then echo "PASS non-UTF-8 file exits 1 with a message"
else echo "FAIL non-UTF-8 file: exit $rc, $(tail -1 "$work/err")"; fail=1; fi

exit $fail
