#!/usr/bin/env bash
# Checks every eval case without a paid run: prompt.md invokes siang:humanize, every regex grader
# compiles as a JS RegExp (the eval runtime's engine), and matches its scaffolded fixture. A
# not_contains grader that misses the fixture can never fail; a contains grader that misses it can
# never pass. Run from anywhere: bash tests/test-graders.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT

fail=0
for d in "$root"/evals/*/; do
  c=$(basename "$d")
  [ -f "$d/case.yaml" ] || continue
  grep -q 'skill: "siang:humanize"' "$d/prompt.md" || { echo "FAIL $c: prompt.md does not invoke siang:humanize"; fail=1; }
  mkdir -p "$work/$c"
  (cd "$work/$c" && bash "$d/scaffold.sh" >/dev/null)
  node - "$d/graders" "$work/$c" "$c" <<'JS' || fail=1
const fs = require('fs'), path = require('path');
const [gdir, ws, c] = process.argv.slice(2);
const all = fs.readdirSync(ws, {recursive: true}).map(f => path.join(ws, f))
  .filter(f => fs.statSync(f).isFile()).map(f => fs.readFileSync(f, 'utf8')).join('\n');
let bad = 0;
for (const g of fs.readdirSync(gdir).sort()) {
  const fm = (fs.readFileSync(path.join(gdir, g), 'utf8').match(/^---\n([\s\S]*?)\n---/) || [])[1] || '';
  if (/^type: tool_used$/m.test(fm)) {
    // A skill-fired grader must accept siang's skill and reject another plugin's skill of the same name.
    const im = fm.match(/^input_match: '((?:[^']|'')*)'$/m);
    if (!im) { console.log(`FAIL ${c}/${g}: tool_used grader has no single-quoted input_match, so it accepts any skill`); bad = 1; }
    else {
      const re = new RegExp(im[1].replace(/''/g, "'"));
      if (!re.test(JSON.stringify({skill: 'siang:humanize'}))) { console.log(`FAIL ${c}/${g}: input_match misses siang:humanize`); bad = 1; }
      if (re.test(JSON.stringify({skill: 'other:humanize'}))) { console.log(`FAIL ${c}/${g}: input_match accepts another plugin's humanize`); bad = 1; }
    }
    continue;
  }
  if (!/^type: regex$/m.test(fm)) continue;
  const m = fm.match(/^pattern: '((?:[^']|'')*)'$/m);
  if (!m) { console.log(`FAIL ${c}/${g}: pattern is not a single-quoted scalar`); bad = 1; continue; }
  const flags = (fm.match(/^flags: (\w+)$/m) || [])[1] || '';
  let re;
  try { re = new RegExp(m[1].replace(/''/g, "'"), flags); }
  catch (e) { console.log(`FAIL ${c}/${g}: ${e.message}`); bad = 1; continue; }
  const file = (fm.match(/path: ([^}\s]+)/) || [])[1];
  const sample = file ? fs.readFileSync(path.join(ws, file), 'utf8') : all;
  if (!re.test(sample)) { console.log(`FAIL ${c}/${g}: pattern does not match the scaffolded fixture, so it cannot discriminate`); bad = 1; }
}
process.exit(bad);
JS
done
[ "$fail" -eq 0 ] && echo "graders: all cases pass" || exit 1
