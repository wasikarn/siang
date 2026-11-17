#!/usr/bin/env bash
# A held-out eval case must be blind: no file in it (scaffold, prompt, graders) shares a run of 40+ characters
# (casing, spacing and punctuation ignored) with any skills/**/*.md. A shared run means a skill example leaked into a case, or
# the case was written from the skill. Run: bash tests/test-leakage.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT
fail=0

scan() {  # scan <repo root>: prints "<case file> <skill file>" for each overlap
  python3 -I - "$1" <<'PY'
import pathlib, sys, unicodedata
N = 40
root = pathlib.Path(sys.argv[1])
def grams(p):  # letters, digits and Thai marks only: casing, spacing and punctuation changes do not hide a copy
    t = "".join(c for c in p.read_text(encoding="utf-8").lower()
                if c.isalnum() or unicodedata.category(c).startswith("M"))
    return {t[i:i + N] for i in range(len(t) - N + 1)}
skills = {p: grams(p) for p in root.glob("skills/**/*.md")}
for case in sorted(root.glob("evals/holdout*")):
    for f in sorted(x for x in case.rglob("*") if x.is_file()):
        g = grams(f)
        for p, sg in skills.items():
            if g & sg:
                print(f.relative_to(root / "evals"), p.relative_to(root))
PY
}

# detector self-test: a planted 45-character copy is flagged, an unrelated case is not
mkdir -p "$work/skills/s" "$work/evals/holdout-a" "$work/evals/holdout-b"
echo 'Never open with a sentence that praises the question you were asked.' > "$work/skills/s/SKILL.md"
echo "cat > draft.md <<'EOF'
Never open with a sentence that praises the question
EOF" > "$work/evals/holdout-a/scaffold.sh"
echo "cat > draft.md <<'EOF'
rolled back the payment deploy after the timeout config broke checkout
EOF" > "$work/evals/holdout-b/scaffold.sh"
out=$(scan "$work")
if [ "$out" = "holdout-a/scaffold.sh skills/s/SKILL.md" ]; then echo "PASS detector flags a planted copy and not an unrelated case"
else echo "FAIL detector self-test: got '$out'"; fail=1; fi

# a copy with other casing, curly quotes and a changed hyphen, one in Thai, and one in a case's prompt.md or grader
# (not only scaffold.sh) is still found
echo 'Don'"'"'t reuse a stock closing line: it reads as machine-written, so cut it.' > "$work/skills/s/two.md"
echo 'ความเห็นที่ไม่มีหลักฐานรองรับไม่ควรเขียนเป็นข้อเท็จจริงในรายงานฉบับนี้เด็ดขาด' > "$work/skills/s/three.md"
mkdir -p "$work/evals/holdout-c/graders" "$work/evals/holdout-d"
echo "DON’T REUSE A STOCK CLOSING LINE: it reads as machine written, so cut it." > "$work/evals/holdout-c/prompt.md"
echo "ความเห็นที่ไม่มีหลักฐาน รองรับไม่ควรเขียนเป็นข้อเท็จจริง ในรายงานฉบับนี้เด็ดขาด" > "$work/evals/holdout-c/graders/g.md"
out=$(scan "$work" | sort | tr '\n' ';')
if [ "$out" = "holdout-a/scaffold.sh skills/s/SKILL.md;holdout-c/graders/g.md skills/s/three.md;holdout-c/prompt.md skills/s/two.md;" ]
then echo "PASS detector sees through casing, punctuation, Thai and non-scaffold case files"
else echo "FAIL detector variants: got '$out'"; fail=1; fi

out=$(scan "$root")
if [ -z "$out" ]; then echo "PASS no holdout case file shares 40+ characters with a skill file"
else echo "FAIL leakage:"; echo "$out"; fail=1; fi

exit $fail
