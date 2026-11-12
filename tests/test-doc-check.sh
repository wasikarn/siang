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

if python3 "$dc" "$work/missing.md" > /dev/null 2>"$work/err"; then
  echo "FAIL missing file should exit non-zero"; fail=1
elif grep -q "cannot read" "$work/err"; then echo "PASS missing file exits non-zero with a message"
else echo "FAIL missing file message"; fail=1; fi

exit $fail
