#!/usr/bin/env bash
# Checks every eval case without a paid run: prompt.md invokes a siang skill, every regex grader
# compiles as a JS RegExp (the eval runtime's engine), and matches its scaffolded fixture. A
# not_contains grader that misses the fixture can never fail; a contains grader that misses it can
# never pass. A contains grader marked '# fixture: absent' checks a corrected form instead, so it must
# miss the fixture. '# must-pass: <text>' and '# must-fail: <text>' lines in a grader's frontmatter are
# sample outputs it must judge right. Run from anywhere: bash tests/test-graders.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT

fail=0
for d in "$root"/evals/*/; do
  c=$(basename "$d")
  [ -f "$d/case.yaml" ] || continue
  skill=$(grep -o '\(skill: \|expects skill \)"siang:[a-z-]*"' "$d/prompt.md" | head -1 | sed 's/.*"\(siang:[a-z-]*\)"/\1/' || true) # fallback: empty means no skill named, reported below
  [ -n "$skill" ] || { echo "FAIL $c: prompt.md does not invoke a siang skill"; fail=1; continue; }
  mkdir -p "$work/$c"
  (cd "$work/$c" && bash "$d/scaffold.sh" >/dev/null)
  node - "$d/graders" "$work/$c" "$c" "$skill" <<'JS' || fail=1
const fs = require('fs'), path = require('path');
const [gdir, ws, c, skill] = process.argv.slice(2);
const bare = skill.split(':')[1];
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
      if (!re.test(JSON.stringify({skill}))) { console.log(`FAIL ${c}/${g}: input_match misses ${skill}`); bad = 1; }
      if (re.test(JSON.stringify({skill: `other:${bare}`}))) { console.log(`FAIL ${c}/${g}: input_match accepts another plugin's ${bare}`); bad = 1; }
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
  // '# must-pass: <text>' / '# must-fail: <text>' lines are outputs the grader has to judge right.
  const passes = t => /^match: not_contains$/m.test(fm) ? !re.test(t) : re.test(t);
  for (const [, kind, t] of fm.matchAll(/^# must-(pass|fail): (.*)$/gm)) {
    if (passes(t) !== (kind === 'pass')) { console.log(`FAIL ${c}/${g}: must-${kind} sample judged wrong: ${t}`); bad = 1; }
  }
  const file = (fm.match(/path: ([^}\s]+)/) || [])[1];
  const sample = file ? fs.readFileSync(path.join(ws, file), 'utf8') : all;
  if (/^# fixture: absent$/m.test(fm)) {
    // A contains grader for a corrected form (BE year, standard spelling): copying the source must fail it.
    if (!/^match: contains$/m.test(fm)) { console.log(`FAIL ${c}/${g}: '# fixture: absent' only fits a contains grader`); bad = 1; }
    else if (re.test(sample)) { console.log(`FAIL ${c}/${g}: pattern matches the fixture, so returning the source unchanged passes`); bad = 1; }
    continue;
  }
  if (!re.test(sample)) { console.log(`FAIL ${c}/${g}: pattern does not match the scaffolded fixture, so it cannot discriminate`); bad = 1; }
}
process.exit(bad);
JS
done
[ "$fail" -eq 0 ] && echo "graders: all cases pass" || exit 1
