#!/usr/bin/env bash
# A held-out eval case must be blind: its scaffold.sh (samples, drafts, planted text) shares no run of 40+ characters
# (whitespace and case ignored) with any skills/**/*.md. A shared run means a skill example leaked into a case, or
# the case was written from the skill. Run: bash tests/test-leakage.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT
fail=0

scan() {  # scan <repo root>: prints "<case> <skill file>" for each overlap
  python3 -I - "$1" <<'PY'
import pathlib, re, sys
N = 40
root = pathlib.Path(sys.argv[1])
def grams(p):
    t = re.sub(r"\s+", "", p.read_text(encoding="utf-8")).lower()
    return {t[i:i + N] for i in range(len(t) - N + 1)}
skills = {p: grams(p) for p in root.glob("skills/**/*.md")}
for sc in sorted(root.glob("evals/holdout*/scaffold.sh")):
    g = grams(sc)
    for p, sg in skills.items():
        if g & sg:
            print(sc.parent.name, p.relative_to(root))
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
if [ "$out" = "holdout-a skills/s/SKILL.md" ]; then echo "PASS detector flags a planted copy and not an unrelated case"
else echo "FAIL detector self-test: got '$out'"; fail=1; fi

out=$(scan "$root")
if [ -z "$out" ]; then echo "PASS no holdout scaffold shares 40+ characters with a skill file"
else echo "FAIL leakage:"; echo "$out"; fail=1; fi

exit $fail
