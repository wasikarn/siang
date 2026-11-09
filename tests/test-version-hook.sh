#!/usr/bin/env bash
# Checks git-hooks/pre-commit in a throwaway repo: a skills/ change without a version bump is
# refused; with a bump, or with no skills/ change, it passes. Run: bash tests/test-version-hook.sh
set -euo pipefail
hook="${HOOK:-$(cd "$(dirname "$0")/.." && pwd)/git-hooks/pre-commit}"
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT
cd "$work"
git init -q && git config user.email t@t && git config user.name t
mkdir -p .claude-plugin skills/x
setver() { printf '{"name": "siang", "version": "%s"}\n' "$1" > .claude-plugin/plugin.json; }
setver 0.1.0; echo a > skills/x/SKILL.md; echo r > README.md
git add . && git commit -q -m init

fail=0
check() { # check <expect 0|1> <label>
  if bash "$hook" 2>/dev/null; then got=0; else got=1; fi
  [ "$got" -eq "$1" ] && echo "PASS $2" || { echo "FAIL $2 (exit $got, want $1)"; fail=1; }
}
echo b > skills/x/SKILL.md; git add skills
check 1 "skills change without a bump is refused"
setver 0.1.1; git add .claude-plugin
check 0 "skills change with a bump passes"
setver 0.1.0; echo a > skills/x/SKILL.md; git add .claude-plugin skills  # back to HEAD's content
echo r2 > README.md; git add README.md
check 0 "non-skills change passes without a bump"
nogit=$(mktemp -d); trap 'python3 -c "import shutil,sys; [shutil.rmtree(p) for p in sys.argv[1:]]" "$work" "$nogit"' EXIT
cd "$nogit"; export GIT_CEILING_DIRECTORIES="$nogit"  # last case: no repo above, so git diff fails
check 1 "a git failure refuses the commit instead of passing"
exit "$fail"
